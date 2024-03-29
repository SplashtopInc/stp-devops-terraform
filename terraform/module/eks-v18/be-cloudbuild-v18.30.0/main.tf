locals {
  # substr(string, offset, length)
  cluster_name_project = lower(var.project)
  cluster_name_region  = join("", [substr(replace(var.region, "-", ""), 0, 3), regex("\\d$", var.region)])
  cluster_name_env     = substr(var.environment, 0, 4)
  cluster_name_suffix  = "${local.cluster_name_env}-${local.cluster_name_region}-${random_string.suffix.result}"

  cloudbuild_short_name   = "cb" #replace(var.cloudbuild_service, "-", "")
  cloudbuild_cluster_name = "${var.project}-${local.cloudbuild_short_name}-${local.cluster_name_suffix}"

  name            = local.cloudbuild_cluster_name
  cluster_version = var.cluster_version
  region          = var.region
  profile         = var.profile
  role_numbers    = regex("[0-9]+", var.aws_assume_role)

  tags = {
    Project     = var.project
    Service     = var.cloudbuild_service
    Environment = var.environment
  }
}

locals {
  worker_ami_owner_id = var.hardened_worker_ami_owner_id
  worker_ami_linux    = var.hardened_worker_ami_linux

  vpc_id     = (var.vpc_id != null ? var.vpc_id : data.aws_vpc.stp-vpc-backend.id)
  subnet_ids = (var.subnet_ids != [] ? var.subnet_ids : data.aws_subnets.stp-vpc-backend-private.ids)
}

# others
locals {
  others_name            = "cloudbuild-others"
  cb_others_kubelet_args = format("--kubelet-extra-args '%s'", var.cb_others_kubelet_args)
}

# wine
locals {
  wine_name            = "cloudbuild-wine"
  cb_wine_kubelet_args = format("--kubelet-extra-args '%s'", var.cb_wine_kubelet_args)
}

# devops
locals {
  devops_name            = "cloudbuild-devops"
  cb_devops_kubelet_args = format("--kubelet-extra-args '%s'", var.cb_devops_kubelet_args)
}

################################################################################
# EKS Module
################################################################################

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.30.0"

  cluster_name                    = local.name
  cluster_version                 = local.cluster_version
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  # whitelist_ip
  cluster_endpoint_public_access_cidrs = var.cluster_endpoint_public_access_cidrs

  cloudwatch_log_group_retention_in_days = var.cloudwatch_log_group_retention_in_days

  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {}
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }

  cluster_encryption_config = [{
    provider_key_arn = aws_kms_key.eks.arn
    resources        = ["secrets"]
  }]

  vpc_id                    = local.vpc_id
  subnet_ids                = local.subnet_ids
  cluster_service_ipv4_cidr = var.cluster_service_ipv4_cidr

  # Extend cluster security group rules
  cluster_security_group_additional_rules = {
    egress_nodes_ephemeral_ports_tcp = {
      description                = "To node 1025-65535"
      protocol                   = "tcp"
      from_port                  = 1025
      to_port                    = 65535
      type                       = "egress"
      source_node_security_group = true
    }
  }

  # Extend node-to-node security group rules
  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
    egress_all = {
      description      = "Node all egress"
      protocol         = "-1"
      from_port        = 0
      to_port          = 0
      type             = "egress"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
    ## ref: https://github.com/kubernetes-sigs/aws-load-balancer-controller/issues/2039#issuecomment-1099032289
    ingress_allow_access_from_control_plane = {
      type                          = "ingress"
      protocol                      = "tcp"
      from_port                     = 9443
      to_port                       = 9443
      source_cluster_security_group = true
      description                   = "Allow access from control plane to webhook port of AWS load balancer controller"
    }
    ingress_allow_metrics_from_control_plane = {
      type                          = "ingress"
      protocol                      = "tcp"
      from_port                     = 8443
      to_port                       = 8443
      source_cluster_security_group = true
      description                   = "Allow access from control plane to metrics-server"
    }
  }

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
    others = {
      name            = format("%s-self-mng", local.others_name)
      use_name_prefix = false
      platform        = var.platform

      subnet_ids = local.subnet_ids

      max_size     = var.cb_others_max_size
      min_size     = var.cb_others_min_size
      desired_size = var.cb_others_desired_size

      ami_id               = data.aws_ami.cloudbuild_node_ami.id
      bootstrap_extra_args = local.cb_others_kubelet_args

      # pre_userdata -> pre_bootstrap_user_data
      # pre_bootstrap_user_data = <<-EOT
      # export CONTAINER_RUNTIME="containerd"
      # export USE_MAX_PODS=false
      # EOT

      # additional_userdata -> post_bootstrap_user_data
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
            kms_key_id            = aws_kms_key.ebs.arn
            delete_on_termination = true
          }
        }
      }

      use_mixed_instances_policy = true
      mixed_instances_policy = {
        instances_distribution = {
          on_demand_base_capacity                  = var.cb_others_on_demand_size
          on_demand_percentage_above_base_capacity = var.cb_others_on_demand_percentage
          # Valid values: lowest-price, capacity-optimized, capacity-optimized-prioritized
          spot_allocation_strategy = "capacity-optimized"
          // 0 for all (only for "lowest-price"), default 10
          spot_instance_pools = 0
        }
        override = var.cb_others_instance_types
      }

      metadata_options = {
        http_endpoint               = "enabled"
        http_tokens                 = "required"
        http_put_response_hop_limit = 2
        instance_metadata_tags      = "disabled"
      }

      iam_role_additional_policies = [
        "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
        "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
        "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
      ]

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
    ## wine node group
    wine = {
      name            = format("%s-self-mng", local.wine_name)
      use_name_prefix = false
      platform        = var.platform

      subnet_ids = local.subnet_ids

      max_size     = var.cb_wine_max_size
      min_size     = var.cb_wine_min_size
      desired_size = var.cb_wine_desired_size

      ami_id               = data.aws_ami.cloudbuild_node_ami.id
      bootstrap_extra_args = local.cb_wine_kubelet_args

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
            kms_key_id            = aws_kms_key.ebs.arn
            delete_on_termination = true
          }
        }
      }

      use_mixed_instances_policy = true
      mixed_instances_policy = {
        instances_distribution = {
          on_demand_base_capacity                  = var.cb_wine_on_demand_base_capacity
          on_demand_percentage_above_base_capacity = var.cb_wine_on_demand_percentage
          # Valid values: lowest-price, capacity-optimized, capacity-optimized-prioritized
          spot_allocation_strategy = "capacity-optimized"
          // 0 for all (only for "lowest-price"), default 10
          spot_instance_pools = 0
        }
        override = var.cb_wine_instance_types
      }

      metadata_options = {
        http_endpoint               = "enabled"
        http_tokens                 = "required"
        http_put_response_hop_limit = 2
        instance_metadata_tags      = "disabled"
      }

      iam_role_additional_policies = [
        "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
        "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
        "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
      ]

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

      max_size     = var.cb_devops_max_size
      min_size     = var.cb_devops_min_size
      desired_size = var.cb_devops_desired_size

      ami_id               = data.aws_ami.cloudbuild_node_ami.id
      bootstrap_extra_args = local.cb_devops_kubelet_args

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
            kms_key_id            = aws_kms_key.ebs.arn
            delete_on_termination = true
          }
        }
      }

      use_mixed_instances_policy = true
      mixed_instances_policy = {
        instances_distribution = {
          on_demand_base_capacity                  = var.cb_devops_on_demand_base_capacity
          on_demand_percentage_above_base_capacity = var.cb_devops_on_demand_percentage
          # Valid values: lowest-price, capacity-optimized, capacity-optimized-prioritized
          spot_allocation_strategy = "capacity-optimized"
          // 0 for all (only for "lowest-price"), default 10
          spot_instance_pools = 0
        }
        override = var.cb_devops_instance_types
      }

      metadata_options = {
        http_endpoint               = "enabled"
        http_tokens                 = "required"
        http_put_response_hop_limit = 2
        instance_metadata_tags      = "disabled"
      }

      iam_role_additional_policies = [
        "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
        "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
        "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
      ]

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
  name = module.eks.cluster_id
}

data "aws_eks_cluster" "this" {
  name = module.eks.cluster_id
}

locals {
  kubeconfig = yamlencode({
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
        token = data.aws_eks_cluster_auth.this.token
      }
    }]
  })

  template_vars = {
    cluster_name     = module.eks.cluster_id
    cluster_endpoint = module.eks.cluster_endpoint
    cluster_ca       = data.aws_eks_cluster.this.certificate_authority[0].data
    cluster_profile  = var.profile
    cluster_region   = var.region
  }

  // kubeconfig = templatefile("./kubeconfig.tpl", local.template_vars)

  map_roles = var.map_roles
  map_users = var.map_users

  # we have to combine the configmap created by the eks module with the externally created node group/profile sub-modules
  current_auth_configmap = yamldecode(module.eks.aws_auth_configmap_yaml)
  updated_auth_configmap_data = {
    data = {
      mapRoles = yamlencode(
        distinct(concat(
          yamldecode(local.current_auth_configmap.data.mapRoles), local.map_roles, )
      ))
      mapUsers = yamlencode(local.map_users)
    }
  }
}

resource "null_resource" "apply" {
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
  description             = "EKS Secret Encryption Key"
  deletion_window_in_days = 7
  enable_key_rotation     = false

  tags = local.tags
}

#tfsec:ignore:aws-kms-auto-rotate-keys:skip key rotate
resource "aws_kms_key" "ebs" {
  #checkov:skip=CKV_AWS_7:sikp
  #ts:skip=AC_AWS_0160 skip key rotate
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
  secretsmanager_name        = "${var.environment}/data/${var.aws_account_name}/${local.name}/${var.cloudbuild_service}"
  secretsmanager_description = "Vault secrets for ${local.name}"
}
#tfsec:ignore:aws-ssm-secret-use-customer-key
resource "aws_secretsmanager_secret" "this" {
  #checkov:skip=CKV_AWS_149: not use KMS key
  #ts:skip=AWS.AKK.DP.HIGH.0012 skip
  #ts:skip=AWS.SecretsManagerSecret.DP.MEDIUM.0036 skip
  name                    = local.secretsmanager_name
  description             = local.secretsmanager_description
  recovery_window_in_days = 7
}