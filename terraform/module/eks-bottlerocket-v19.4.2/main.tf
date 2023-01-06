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
  create_aws_auth_configmap = true
  manage_aws_auth_configmap = true

  aws_auth_roles    = var.aws_auth_roles
  aws_auth_users    = var.aws_auth_users
  aws_auth_accounts = var.aws_auth_accounts


  # # Extend node-to-node security group rules
  # node_security_group_additional_rules = {
  #   ## ref: https://github.com/kubernetes-sigs/aws-load-balancer-controller/issues/2039#issuecomment-1099032289
  #   ingress_allow_access_from_control_plane = {
  #     type                          = "ingress"
  #     protocol                      = "tcp"
  #     from_port                     = 9443
  #     to_port                       = 9443
  #     source_cluster_security_group = true
  #     description                   = "Allow access from control plane to webhook port of AWS load balancer controller"
  #   }
  #   ingress_allow_metrics_from_control_plane = {
  #     type                          = "ingress"
  #     protocol                      = "tcp"
  #     from_port                     = 8443
  #     to_port                       = 8443
  #     source_cluster_security_group = true
  #     description                   = "Allow access from control plane to metrics-server"
  #   }
  # }

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
        [settings.kubernetes.node-taints]
        dedicated = "experimental:PreferNoSchedule"
        special = "true:NoSchedule"
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
            volume_size           = 100
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
      iam_role_name            = "self-managed-node-group-sonarqube"
      iam_role_use_name_prefix = false
      iam_role_description     = "Self managed node group sonarqube role"
      iam_role_tags = {
        Purpose = "Protector of the kubelet"
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
      iam_role_name            = "self-managed-node-group-sonarqube"
      iam_role_use_name_prefix = false
      iam_role_description     = "Self managed node group sonarqube role"
      iam_role_tags = {
        Purpose = "Protector of the kubelet"
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