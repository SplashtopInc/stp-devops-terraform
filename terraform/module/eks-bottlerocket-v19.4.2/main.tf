resource "random_string" "suffix" {
  length  = 8
  upper   = false # no upper for RDS related resources naming rule
  special = false
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
  }
}

data "aws_caller_identity" "current" {}
data "aws_availability_zones" "available" {}

locals {
  cluster_name_project = lower(var.project)
  cluster_name_region  = join("", [substr(replace(var.region, "-", ""), 0, 3), regex("\\d$", var.region)])
  cluster_name_env     = substr(var.environment, 0, 4)
  cluster_name_account = var.account
  cluster_name_suffix  = "${local.cluster_name_account}-${local.cluster_name_env}-${local.cluster_name_region}-${random_string.suffix.result}"

  name   = "${local.cluster_name_project}-${local.cluster_name_suffix}"
  region = var.region

  azs = slice(data.aws_availability_zones.available.names, 0, 3)

  role_numbers = data.aws_caller_identity.current.account_id

  tags = {
    Project     = var.project
    Environment = var.environment
  }
}

################################################################################
# EKS Module
################################################################################

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.4.2"

  create                          = var.create
  cluster_name                    = var.cluster_name != "" ? var.cluster_name : local.name
  cluster_version                 = var.cluster_version
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  # whitelist_ip
  cluster_endpoint_public_access_cidrs = var.cluster_endpoint_public_access_cidrs

  cloudwatch_log_group_retention_in_days = var.cloudwatch_log_group_retention_in_days

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  # Self managed node groups will not automatically create the aws-auth configmap so we need to
  # create_aws_auth_configmap = true
  # manage_aws_auth_configmap = true

  # aws_auth_roles    = var.aws_auth_roles
  # aws_auth_users    = var.aws_auth_users
  # aws_auth_accounts = var.aws_auth_accounts

  ################################################################################
  # IAM Role
  ################################################################################

  iam_role_name            = var.cluster_name != "" ? var.cluster_name : local.name
  iam_role_use_name_prefix = false

  self_managed_node_group_defaults = {
    # enable discovery of autoscaling groups by cluster-autoscaler
    autoscaling_group_tags = {
      "k8s.io/cluster-autoscaler/enabled" : true,
      "k8s.io/cluster-autoscaler/${local.name}" : "owned",
    }
  }

  self_managed_node_groups = {
    # Default node group - as provisioned by the module defaults
    # default_node_group = {}

    # runner node group
    runner = {
      name   = "runner-self-mng"
      ami_id = data.aws_ami.eks_default_bottlerocket.id

      platform = "bottlerocket"

      subnet_ids = var.subnet_ids

      max_size     = var.runner_max_size
      min_size     = var.runner_min_size
      desired_size = var.runner_desired_size

      bootstrap_extra_args = <<-EOT
        # The admin host container provides SSH access and runs with "superpowers".
        # It is disabled by default, but can be disabled explicitly.
        [settings.host-containers.admin]
        enabled = false
        # The control host container provides out-of-band access via SSM.
        # It is enabled by default, and can be disabled if you do not expect to use SSM.
        # This could leave you with no way to access the API and change settings on an existing node!
        [settings.host-containers.control]
        enabled = true
        # extra args added
        [settings.kernel]
        lockdown = "integrity"
        [settings.kubernetes.node-labels]
        app = "runner"
        runner = "true"
        # [settings.kubernetes.node-taints]
        # dedicated = "experimental:PreferNoSchedule"
        # special = "true:NoSchedule"
      EOT

      # pre_bootstrap_user_data = <<-EOT
      #   export CONTAINER_RUNTIME="containerd"
      #   export USE_MAX_PODS=false
      # EOT

      # post_bootstrap_user_data = <<-EOT
      #   echo "you are free little kubelet!"
      # EOT

      launch_template_name            = "self-managed-runner"
      launch_template_use_name_prefix = true
      launch_template_description     = "Self managed node group runner launch template"

      ebs_optimized     = true
      enable_monitoring = true

      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size           = 200
            volume_type           = "gp3"
            iops                  = 3000
            throughput            = 150
            delete_on_termination = true
          }
        }
      }

      use_mixed_instances_policy = true
      mixed_instances_policy = {
        instances_distribution = {
          on_demand_base_capacity                  = var.runner_on_demand_base_capacity
          on_demand_percentage_above_base_capacity = var.runner_on_demand_percentage
          # Valid values: lowest-price, capacity-optimized, capacity-optimized-prioritized
          spot_allocation_strategy = "capacity-optimized"
          // 0 for all (only for "lowest-price"), default 10
          spot_instance_pools = 0
        }
        override = var.runner_instance_types
      }

      metadata_options = {
        http_endpoint               = "enabled"
        http_tokens                 = "required"
        http_put_response_hop_limit = 2
        instance_metadata_tags      = "disabled"
      }

      # capacity_reservation_specification = {
      #   capacity_reservation_target = {
      #     capacity_reservation_id = aws_ec2_capacity_reservation.targeted.id
      #   }
      # }

      create_iam_role          = false
      iam_role_name            = "${local.name}-runner"
      iam_role_use_name_prefix = false
      iam_role_description     = "Self managed node group runner role"
      iam_role_tags = {
        Purpose = "Protector of the runner group"
      }
      iam_role_additional_policies = {
        additional_1 = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
        additional_2 = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
        additional_3 = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
      }
    }

    # sonarqube
    sonarqube = {
      name   = "sonarqube-self-mng"
      ami_id = data.aws_ami.eks_default_bottlerocket.id

      platform = "bottlerocket"

      subnet_ids = var.subnet_ids

      max_size     = var.sonarqube_max_size
      min_size     = var.sonarqube_min_size
      desired_size = var.sonarqube_desired_size

      bootstrap_extra_args = <<-EOT
        # The admin host container provides SSH access and runs with "superpowers".
        # It is disabled by default, but can be disabled explicitly.
        [settings.host-containers.admin]
        enabled = false
        # The control host container provides out-of-band access via SSM.
        # It is enabled by default, and can be disabled if you do not expect to use SSM.
        # This could leave you with no way to access the API and change settings on an existing node!
        [settings.host-containers.control]
        enabled = true
        # extra args added
        [settings.kernel]
        lockdown = "integrity"
        [settings.kubernetes.node-labels]
        app = "sonarqube"
        sonarqube = "true"
        [settings.kubernetes.node-taints]
        sonarqube = "true:NoSchedule"
      EOT

      # pre_bootstrap_user_data = <<-EOT
      #   export CONTAINER_RUNTIME="containerd"
      #   export USE_MAX_PODS=false
      # EOT

      # post_bootstrap_user_data = <<-EOT
      #   echo "you are free little kubelet!"
      # EOT

      launch_template_name            = "self-managed-sonarqube"
      launch_template_use_name_prefix = true
      launch_template_description     = "Self managed node group sonarqube launch template"

      ebs_optimized     = true
      enable_monitoring = true

      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size           = 200
            volume_type           = "gp3"
            iops                  = 3000
            throughput            = 150
            delete_on_termination = true
          }
        }
      }

      use_mixed_instances_policy = true
      mixed_instances_policy = {
        instances_distribution = {
          on_demand_base_capacity                  = var.sonarqube_on_demand_base_capacity
          on_demand_percentage_above_base_capacity = var.sonarqube_on_demand_percentage
          # Valid values: lowest-price, capacity-optimized, capacity-optimized-prioritized
          spot_allocation_strategy = "capacity-optimized"
          // 0 for all (only for "lowest-price"), default 10
          spot_instance_pools = 0
        }
        override = var.sonarqube_instance_types
      }

      metadata_options = {
        http_endpoint               = "enabled"
        http_tokens                 = "required"
        http_put_response_hop_limit = 2
        instance_metadata_tags      = "disabled"
      }

      # capacity_reservation_specification = {
      #   capacity_reservation_target = {
      #     capacity_reservation_id = aws_ec2_capacity_reservation.targeted.id
      #   }
      # }

      create_iam_role          = false
      iam_role_name            = "${local.name}-sonarqube"
      iam_role_use_name_prefix = false
      iam_role_description     = "Self managed node group sonarqube role"
      iam_role_tags = {
        Purpose = "Protector of the sonarqube group"
      }
      iam_role_additional_policies = {
        additional_1 = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
        additional_2 = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
        additional_3 = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
      }

      timeouts = {
        create = "80m"
        update = "80m"
        delete = "80m"
      }

      tags = {}
    }
  }

  tags = local.tags
}

################################################################################
# Supporting Resources
################################################################################

data "aws_ami" "eks_default" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amazon-eks-node-${var.cluster_version}-v*"]
  }
}

data "aws_ami" "eks_default_bottlerocket" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["bottlerocket-aws-k8s-${var.cluster_version}-x86_64-*"]
  }
}

################################################################################
# aws-auth configmap
# Only EKS managed node groups automatically add roles to aws-auth configmap
# so we need to ensure fargate profiles and self-managed node roles are added
################################################################################

data "aws_eks_cluster_auth" "this" {
  count = var.create ? 1 : 0
  name  = module.eks.cluster_name
}

data "aws_eks_cluster" "this" {
  count = var.create ? 1 : 0
  name  = module.eks.cluster_name
}

locals {
  kubeconfig = var.create ? yamlencode({
    apiVersion      = "v1"
    kind            = "Config"
    current-context = "terraform"
    clusters = [{
      name = module.eks.cluster_name
      cluster = {
        certificate-authority-data = module.eks.cluster_certificate_authority_data
        server                     = module.eks.cluster_endpoint
      }
    }]
    contexts = [{
      name = "terraform"
      context = {
        cluster = module.eks.cluster_name
        user    = "terraform"
      }
    }]
    users = [{
      name = "terraform"
      user = {
        token = data.aws_eks_cluster_auth.this[0].token
      }
    }]
  }) : "{}"

  template_vars = var.create ? {
    cluster_name     = module.eks.cluster_name
    cluster_endpoint = module.eks.cluster_endpoint
    cluster_ca       = data.aws_eks_cluster.this[0].certificate_authority[0].data
    cluster_profile  = var.profile
    cluster_region   = var.region
  } : {}

  // kubeconfig = templatefile("./kubeconfig.tpl", local.template_vars)

  map_roles = var.map_roles
  map_users = var.map_users

  # we have to combine the configmap created by the eks module with the externally created node group/profile sub-modules
  current_auth_configmap = module.eks.aws_auth_configmap_yaml != null ? yamldecode(module.eks.aws_auth_configmap_yaml) : yamldecode("")
  updated_auth_configmap_data = var.create ? {
    data = {
      mapRoles = yamlencode(
        distinct(concat(
          yamldecode(local.current_auth_configmap.data.mapRoles), local.map_roles, )
      ))
      mapUsers = yamlencode(local.map_users)
    }
    } : {
  }
}

resource "null_resource" "apply" {
  count = var.create ? 1 : 0
  triggers = {
    kubeconfig = base64encode(local.kubeconfig)
    cmd_patch  = <<-EOT
      kubectl create configmap aws-auth -n kube-system --dry-run=client -o yaml --kubeconfig <(echo $KUBECONFIG | base64 --decode) | kubectl apply -f - -n kube-system --kubeconfig <(echo $KUBECONFIG | base64 --decode)
      kubectl patch configmap/aws-auth -n kube-system --type merge -p '${chomp(jsonencode(local.updated_auth_configmap_data))}' --kubeconfig <(echo $KUBECONFIG | base64 --decode)
    EOT
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    environment = {
      KUBECONFIG = self.triggers.kubeconfig
    }
    command = self.triggers.cmd_patch
  }
}

################################################################################
# Secret Manager Module for eks output
################################################################################

locals {
  secretsmanager_eks_name        = var.create ? "cicd/${var.environment}/data/eks/${local.name}" : ""
  secretsmanager_eks_description = "Vault secrets for ${local.name} eks"
  secretsmanager_json = {
    "cluster_name" = "${module.eks.cluster_name}",
    ##"The ID of the EKS cluster. Note: currently a value is returned only for local EKS clusters created on Outposts"
    ## use module.eks.cluster_name instead of module.eks.cluster_id
    "cluster_id"                                = "${module.eks.cluster_name}",
    "cluster_endpoint"                          = "${module.eks.cluster_endpoint}",
    "decode_cluster_certificate_authority_data" = "${base64decode(module.eks.cluster_certificate_authority_data)}"
  }
}
#tfsec:ignore:aws-ssm-secret-use-customer-key
resource "aws_secretsmanager_secret" "eks" {
  #checkov:skip=CKV_AWS_149: not use KMS key
  #ts:skip=AWS.AKK.DP.HIGH.0012 skip
  #ts:skip=AWS.SecretsManagerSecret.DP.MEDIUM.0036 skip
  count                   = var.create ? 1 : 0
  name                    = local.secretsmanager_eks_name
  description             = local.secretsmanager_eks_description
  recovery_window_in_days = 7
}

resource "aws_secretsmanager_secret_version" "eks" {
  count         = var.create ? 1 : 0
  secret_id     = resource.aws_secretsmanager_secret.eks[0].id
  secret_string = jsonencode(local.secretsmanager_json)
}