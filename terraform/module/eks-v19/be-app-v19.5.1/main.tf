resource "random_string" "suffix" {
  count   = var.create ? 1 : 0
  length  = 8
  upper   = false # no upper for RDS related resources naming rule
  special = false
}

locals {
  # substr(string, offset, length)
  cluster_name_project = lower(var.project)
  cluster_name_region  = join("", [substr(replace(var.region, "-", ""), 0, 3), regex("\\d$", var.region)])
  cluster_name_env     = substr(var.environment, 0, 4)
  cluster_name_suffix  = var.create ? "${local.cluster_name_env}-${local.cluster_name_region}-${random_string.suffix[0].result}" : ""

  app_short_name   = replace(var.app_service, "-", "")
  app_cluster_name = "${local.cluster_name_project}-${local.app_short_name}-${local.cluster_name_suffix}"

  name            = local.app_cluster_name
  cluster_version = var.cluster_version
  region          = var.region
  profile         = var.profile
  role_numbers    = regex("[0-9]+", var.aws_assume_role)

  tags = {
    Project     = var.project
    Environment = var.environment
  }
}

locals {
  worker_ami_owner_id = var.hardened_worker_ami_owner_id
  worker_ami_linux    = var.hardened_worker_ami_linux

  vpc_id     = var.vpc_id == null ? data.aws_vpc.stp-vpc-pub.id : var.vpc_id
  subnet_ids = length(var.subnet_ids) == 0 ? data.aws_subnets.stp-vpc-pub-private.ids : var.subnet_ids
}

# app
locals {
  api_name            = "be-app"
  be_api_kubelet_args = format("--kubelet-extra-args '%s'", var.be_api_kubelet_args)
}

# my
locals {
  my_name            = "be-my"
  be_my_kubelet_args = format("--kubelet-extra-args '%s'", var.be_my_kubelet_args)
}

# devops
locals {
  devops_name            = "be-devops"
  be_devops_kubelet_args = format("--kubelet-extra-args '%s'", var.be_devops_kubelet_args)
}

################################################################################
# EKS Module
################################################################################

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.5.1"

  create                          = var.create
  cluster_name                    = local.name
  cluster_version                 = local.cluster_version
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  # whitelist_ip
  cluster_endpoint_public_access_cidrs = var.cluster_endpoint_public_access_cidrs

  cloudwatch_log_group_retention_in_days = var.cloudwatch_log_group_retention_in_days

  cluster_addons = {
    preserve    = true
    most_recent = true

    timeouts = {
      create = "25m"
      delete = "10m"
    }
    coredns    = {}
    kube-proxy = {}
    vpc-cni    = {}
  }

  cluster_encryption_config = {
    provider_key_arn = var.create ? aws_kms_key.eks[0].arn : null
    rresources       = ["secrets"]
  }

  vpc_id                    = local.vpc_id
  subnet_ids                = local.subnet_ids
  cluster_service_ipv4_cidr = var.cluster_service_ipv4_cidr

  self_managed_node_group_defaults = {
    create_security_group = false

    # enable discovery of autoscaling groups by cluster-autoscaler
    autoscaling_group_tags = {
      "k8s.io/cluster-autoscaler/enabled" : true,
      "k8s.io/cluster-autoscaler/${local.name}" : "owned",
    }
  }

  # Dynamic Blocks documents a way to create multiple repeatable nested blocks within a resource or other construct.
  # Dynamic blocks don't work on modules.
  # https://github.com/terraform-aws-modules/terraform-aws-eks/issues/897

  self_managed_node_groups = {
    ## api node group
    api = {
      name            = format("%s-self-mng", local.api_name)
      use_name_prefix = false
      platform        = var.platform

      subnet_ids = local.subnet_ids

      max_size     = var.be_api_max_size
      min_size     = var.be_api_min_size
      desired_size = var.be_api_desired_size

      ami_id               = data.aws_ami.beapp_node_ami.id
      bootstrap_extra_args = local.be_api_kubelet_args

      # pre_bootstrap_user_data = <<-EOT
      # export CONTAINER_RUNTIME="containerd"
      # export USE_MAX_PODS=false
      # EOT

      # post_bootstrap_user_data = <<-EOT
      # echo "you are free little kubelet!"
      # EOT

      ebs_optimized     = true
      enable_monitoring = true

      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size           = 50
            volume_type           = "gp3"
            iops                  = 3000
            throughput            = 150
            encrypted             = true
            kms_key_id            = var.create ? aws_kms_key.ebs[0].arn : null
            delete_on_termination = true
          }
        }
      }

      use_mixed_instances_policy = true
      mixed_instances_policy = {
        instances_distribution = {
          on_demand_base_capacity                  = var.be_api_on_demand_base_capacity
          on_demand_percentage_above_base_capacity = var.be_api_on_demand_percentage
          # Valid values: lowest-price, capacity-optimized, capacity-optimized-prioritized
          spot_allocation_strategy = "capacity-optimized"
          // 0 for all (only for "lowest-price"), default 10
          spot_instance_pools = 0
        }
        override = var.be_api_instance_types
      }

      metadata_options = {
        http_endpoint               = "enabled"
        http_tokens                 = "required"
        http_put_response_hop_limit = 2
        instance_metadata_tags      = "disabled"
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

      autoscaling_group_tags = {
        "k8s.io/cluster-autoscaler/enabled" : true,
        "k8s.io/cluster-autoscaler/${local.name}" : "owned",
      }

      tags = {}
    }
    ## my node group
    my = {
      name            = format("%s-self-mng", local.my_name)
      use_name_prefix = false
      platform        = var.platform

      subnet_ids = local.subnet_ids

      max_size     = var.be_my_max_size
      min_size     = var.be_my_min_size
      desired_size = var.be_my_desired_size

      ami_id               = data.aws_ami.beapp_node_ami.id
      bootstrap_extra_args = local.be_my_kubelet_args

      # pre_bootstrap_user_data = <<-EOT
      # export CONTAINER_RUNTIME="containerd"
      # export USE_MAX_PODS=false
      # EOT

      # post_bootstrap_user_data = <<-EOT
      # echo "you are free little kubelet!"
      # EOT

      ebs_optimized     = true
      enable_monitoring = true

      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size           = 50
            volume_type           = "gp3"
            iops                  = 3000
            throughput            = 150
            encrypted             = true
            kms_key_id            = var.create ? aws_kms_key.ebs[0].arn : null
            delete_on_termination = true
          }
        }
      }

      use_mixed_instances_policy = true
      mixed_instances_policy = {
        instances_distribution = {
          on_demand_base_capacity                  = var.be_my_on_demand_base_capacity
          on_demand_percentage_above_base_capacity = var.be_my_on_demand_percentage
          # Valid values: lowest-price, capacity-optimized, capacity-optimized-prioritized
          spot_allocation_strategy = "capacity-optimized"
          // 0 for all (only for "lowest-price"), default 10
          spot_instance_pools = 0
        }
        override = var.be_my_instance_types
      }

      metadata_options = {
        http_endpoint               = "enabled"
        http_tokens                 = "required"
        http_put_response_hop_limit = 2
        instance_metadata_tags      = "disabled"
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

      autoscaling_group_tags = {
        "k8s.io/cluster-autoscaler/enabled" : true,
        "k8s.io/cluster-autoscaler/${local.name}" : "owned",
      }

      tags = {}
    }
    ## devops node group
    devops = {
      name            = format("%s-self-mng", local.devops_name)
      use_name_prefix = false
      platform        = var.platform

      subnet_ids = local.subnet_ids

      max_size     = var.be_devops_max_size
      min_size     = var.be_devops_min_size
      desired_size = var.be_devops_desired_size

      ami_id               = data.aws_ami.beapp_node_ami.id
      bootstrap_extra_args = local.be_devops_kubelet_args

      # pre_bootstrap_user_data = <<-EOT
      # export CONTAINER_RUNTIME="containerd"
      # export USE_MAX_PODS=false
      # EOT

      # post_bootstrap_user_data = <<-EOT
      # echo "you are free little kubelet!"
      # EOT

      ebs_optimized     = true
      enable_monitoring = true

      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size           = 50
            volume_type           = "gp3"
            iops                  = 3000
            throughput            = 150
            encrypted             = true
            kms_key_id            = var.create ? aws_kms_key.ebs[0].arn : null
            delete_on_termination = true
          }
        }
      }

      use_mixed_instances_policy = true
      mixed_instances_policy = {
        instances_distribution = {
          on_demand_base_capacity                  = var.be_devops_on_demand_base_capacity
          on_demand_percentage_above_base_capacity = var.be_devops_on_demand_percentage
          # Valid values: lowest-price, capacity-optimized, capacity-optimized-prioritized
          spot_allocation_strategy = "capacity-optimized"
          // 0 for all (only for "lowest-price"), default 10
          spot_instance_pools = 0
        }
        override = var.be_devops_instance_types
      }

      metadata_options = {
        http_endpoint               = "enabled"
        http_tokens                 = "required"
        http_put_response_hop_limit = 2
        instance_metadata_tags      = "disabled"
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

      autoscaling_group_tags = {
        "k8s.io/cluster-autoscaler/enabled" : true,
        "k8s.io/cluster-autoscaler/${local.name}" : "owned",
      }

      tags = {}
    }
  }

  tags = local.tags
}

################################################################################
# aws-auth configmap
# Only EKS managed node groups automatically add roles to aws-auth configmap
# so we need to ensure fargate profiles and self-managed node roles are added
################################################################################

data "aws_eks_cluster_auth" "this" {
  count = var.create ? 1 : 0
  name  = module.eks.cluster_id
}

data "aws_eks_cluster" "this" {
  count = var.create ? 1 : 0
  name  = module.eks.cluster_id
}

locals {
  kubeconfig = var.create ? yamlencode({
    apiVersion      = "v1"
    kind            = "Config"
    current-context = "terraform"
    clusters = [{
      name = module.eks.cluster_id
      cluster = {
        certificate-authority-data = module.eks.cluster_certificate_authority_data
        server                     = module.eks.cluster_endpoint
      }
    }]
    contexts = [{
      name = "terraform"
      context = {
        cluster = module.eks.cluster_id
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
    cluster_name     = module.eks.cluster_id
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
# Supporting Resources
################################################################################
#tfsec:ignore:aws-kms-auto-rotate-keys:skip key rotate
resource "aws_kms_key" "eks" {
  #checkov:skip=CKV_AWS_7:sikp
  #ts:skip=AC_AWS_0160 skip key rotate
  count                   = var.create ? 1 : 0
  description             = "EKS Secret Encryption Key"
  deletion_window_in_days = 7
  enable_key_rotation     = false

  tags = local.tags
}

#tfsec:ignore:aws-kms-auto-rotate-keys:skip key rotate
resource "aws_kms_key" "ebs" {
  #checkov:skip=CKV_AWS_7:sikp
  #ts:skip=AC_AWS_0160 skip key rotate
  count                   = var.create ? 1 : 0
  description             = "Customer managed key to encrypt self managed node group volumes"
  deletion_window_in_days = 7
  policy                  = data.aws_iam_policy_document.ebs.json
}

# This policy is required for the KMS key used for EKS root volumes, so the cluster is allowed to enc/dec/attach encrypted EBS volumes
data "aws_iam_policy_document" "ebs" {
  #checkov:skip=CKV_AWS_111:sikp
  #checkov:skip=CKV_AWS_109:sikp
  # Copy of default KMS policy that lets you manage it
  statement {
    sid       = "Enable IAM User Permissions"
    actions   = ["kms:*"]
    resources = ["*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }

  # Required for EKS
  statement {
    sid = "Allow service-linked role use of the CMK"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
    resources = ["*"]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling", # required for the ASG to manage encrypted volumes for nodes
        module.eks.cluster_iam_role_arn,                                                                                                            # required for the cluster / persistentvolume-controller to create encrypted PVCs
      ]
    }
  }

  statement {
    sid       = "Allow attachment of persistent resources"
    actions   = ["kms:CreateGrant"]
    resources = ["*"]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling", # required for the ASG to manage encrypted volumes for nodes
        module.eks.cluster_iam_role_arn,                                                                                                            # required for the cluster / persistentvolume-controller to create encrypted PVCs
      ]
    }

    condition {
      test     = "Bool"
      variable = "kms:GrantIsForAWSResource"
      values   = ["true"]
    }
  }
}
################################################################################
# Secret Manager Module
################################################################################

locals {
  secretsmanager_name        = var.create ? "${var.environment}/data/${var.aws_account_name}/${local.app_cluster_name}/${local.api_name}" : ""
  secretsmanager_description = "Vault secrets for ${local.app_cluster_name} be-app"
}
#tfsec:ignore:aws-ssm-secret-use-customer-key
resource "aws_secretsmanager_secret" "this" {
  #checkov:skip=CKV_AWS_149: not use KMS key
  #ts:skip=AWS.AKK.DP.HIGH.0012 skip
  #ts:skip=AWS.SecretsManagerSecret.DP.MEDIUM.0036 skip
  count                   = var.create ? 1 : 0
  name                    = local.secretsmanager_name
  description             = local.secretsmanager_description
  recovery_window_in_days = 7
}

################################################################################
# Secret Manager Module for eks output
################################################################################

locals {
  secretsmanager_eks_name        = var.create ? "${var.environment}/data/eks/${local.app_cluster_name}" : ""
  secretsmanager_eks_description = "Vault secrets for ${local.app_cluster_name} eks"
  secretsmanager_json = {
    "cluster_id"                                = "${module.eks.cluster_id}",
    "cluster_endpoint"                          = "${module.eks.cluster_endpoint}",
    "decode_cluster_certificate_authority_data" = "${base64decode(module.eks.cluster_certificate_authority_data)}",
    "secretsmanager_secret_name"                = "${local.secretsmanager_name}"
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

