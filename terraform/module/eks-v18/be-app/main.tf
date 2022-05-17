# ref: https://github.com/terraform-aws-modules/terraform-aws-eks/tree/master/examples/self_managed_node_group
locals {
  # substr(string, offset, length)
  cluster_name_project = lower(var.project)
  cluster_name_region  = join("", [substr(replace(var.region, "-", ""), 0, 3), regex("\\d$", var.region)])
  cluster_name_env     = substr(var.environment, 0, 4)
  cluster_name_account = var.account
  cluster_name_suffix  = "${local.cluster_name_env}-${local.cluster_name_region}-${random_string.suffix.result}"

  app_short_name        = replace(var.app_service, "-", "")
  mymail_short_name     = replace(var.mymail_service, "-", "")
  cloudbuild_short_name = replace(var.cloudbuild_service, "-", "")
  relayfe_short_name    = replace(var.relayfe_service, "-", "")
  relayrs_short_name    = replace(var.relayrs_service, "-", "")

  app_cluster_name        = "${var.project}-${local.app_short_name}-${local.cluster_name_suffix}"
  mymail_cluster_name     = "${var.project}-${local.mymail_short_name}-${local.cluster_name_suffix}"
  cloudbuild_cluster_name = "${var.project}-${local.cloudbuild_short_name}-${local.cluster_name_suffix}"
  relayfe_cluster_name    = "${var.project}-${local.relayfe_short_name}-${local.cluster_name_suffix}"
  relayrs_cluster_name    = "${var.project}-${local.relayrs_short_name}-${local.cluster_name_suffix}"

  name            = local.app_cluster_name
  cluster_version = var.cluster_version
  region          = var.region

  tags = {
    Project     = var.project
    Environment = var.environment
  }

}

locals {
  worker_ami_owner_id = var.hardened_worker_ami_owner_id
  worker_ami_linux    = var.hardened_worker_ami_linux

  vpc_id     = (var.vpc_id != null ? var.vpc_id : data.aws_vpc.stp-vpc-pub.id)
  subnet_ids = (var.subnet_ids != [] ? var.subnet_ids : data.aws_subnets.stp-vpc-pub-private.ids)
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
  version = "18.20.4"

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
    // aws-ebs-csi-driver = {}
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
  }

  self_managed_node_group_defaults = {
    // disk_size = 50
  }

  self_managed_node_groups = {
    # api node group
    api = {
      name            = format("%s-self-mng", local.api_name)
      create          = true
      use_name_prefix = false
      platform        = var.platform

      subnet_ids = local.subnet_ids

      public_ip = false

      max_size     = var.be_api_max_size
      min_size     = var.be_api_min_size
      desired_size = var.be_api_desired_size

      ami_id               = data.aws_ami.beapp_node_ami.id
      bootstrap_extra_args = local.be_api_kubelet_args

      pre_bootstrap_user_data = <<-EOT
      export CONTAINER_RUNTIME="containerd"
      export USE_MAX_PODS=false
      EOT

      post_bootstrap_user_data = <<-EOT
      echo "you are free little kubelet!"
      EOT

      // disk_size     = 50
      instance_type = "m5.large"

      launch_template_name            = format("%s-self-managed", local.api_name)
      launch_template_use_name_prefix = true
      launch_template_description     = format("Self managed %s node group", local.api_name)

      ebs_optimized          = true
      vpc_security_group_ids = [aws_security_group.additional.id]
      enable_monitoring      = true

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

      create_iam_role          = true
      iam_role_name            = format("%s-self-managed-node-group-role", local.api_name)
      iam_role_use_name_prefix = false
      iam_role_description     = format("Self managed node group %s role", local.api_name)
      iam_role_tags = {
        Purpose = "Protector of the kubelet"
      }
      iam_role_additional_policies = [
        "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
        "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
        "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
      ]

      create_security_group          = true
      security_group_name            = format("%s-node-group-sg", local.api_name)
      security_group_use_name_prefix = false
      security_group_description     = format("%s node group security group", local.api_name)
      security_group_rules = {
        phoneOut = {
          description = "Hello CloudFlare"
          protocol    = "udp"
          from_port   = 53
          to_port     = 53
          type        = "egress"
          cidr_blocks = ["1.1.1.1/32"]
        }
        phoneHome = {
          description                   = "Hello cluster"
          protocol                      = "udp"
          from_port                     = 53
          to_port                       = 53
          type                          = "egress"
          source_cluster_security_group = true # bit of reflection lookup
        }
      }
      security_group_tags = {
        Purpose = "Protector of the kubelet"
      }

      timeouts = {
        create = "80m"
        update = "80m"
        delete = "80m"
      }

      tags = {}
    }

    # my node group
    my = {
      name            = format("%s-self-mng", local.my_name)
      create          = true
      use_name_prefix = false
      platform        = var.platform

      subnet_ids = local.subnet_ids

      public_ip = false

      max_size     = var.be_my_max_size
      min_size     = var.be_my_min_size
      desired_size = var.be_my_desired_size

      ami_id               = data.aws_ami.beapp_node_ami.id
      bootstrap_extra_args = local.be_my_kubelet_args

      pre_bootstrap_user_data = <<-EOT
      export CONTAINER_RUNTIME="containerd"
      export USE_MAX_PODS=false
      EOT

      post_bootstrap_user_data = <<-EOT
      echo "you are free little kubelet!"
      EOT

      // disk_size     = 50
      instance_type = "m5.large"

      launch_template_name            = format("%s-self-managed", local.my_name)
      launch_template_use_name_prefix = true
      launch_template_description     = format("Self managed %s node group", local.my_name)

      ebs_optimized          = true
      vpc_security_group_ids = [aws_security_group.additional.id]
      enable_monitoring      = true

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

      create_iam_role          = true
      iam_role_name            = format("%s-self-managed-node-group-role", local.my_name)
      iam_role_use_name_prefix = false
      iam_role_description     = format("Self managed node group %s role", local.my_name)
      iam_role_tags = {
        Purpose = "Protector of the kubelet"
      }
      iam_role_additional_policies = [
        "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
        "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
        "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
      ]

      create_security_group          = true
      security_group_name            = format("%s-node-group-sg", local.my_name)
      security_group_use_name_prefix = false
      security_group_description     = format("%s node group security group", local.my_name)
      security_group_rules = {
        phoneOut = {
          description = "Hello CloudFlare"
          protocol    = "udp"
          from_port   = 53
          to_port     = 53
          type        = "egress"
          cidr_blocks = ["1.1.1.1/32"]
        }
        phoneHome = {
          description                   = "Hello cluster"
          protocol                      = "udp"
          from_port                     = 53
          to_port                       = 53
          type                          = "egress"
          source_cluster_security_group = true # bit of reflection lookup
        }
      }
      security_group_tags = {
        Purpose = "Protector of the kubelet"
      }

      timeouts = {
        create = "80m"
        update = "80m"
        delete = "80m"
      }

      tags = {}
    }

    # devops node group
    devops = {
      name            = format("%s-self-mng", local.devops_name)
      create          = true
      use_name_prefix = false
      platform        = var.platform

      subnet_ids = local.subnet_ids

      public_ip = false

      max_size     = var.be_devops_max_size
      min_size     = var.be_devops_min_size
      desired_size = var.be_devops_desired_size

      ami_id               = data.aws_ami.beapp_node_ami.id
      bootstrap_extra_args = local.be_devops_kubelet_args

      pre_bootstrap_user_data = <<-EOT
      export CONTAINER_RUNTIME="containerd"
      export USE_MAX_PODS=false
      EOT

      post_bootstrap_user_data = <<-EOT
      echo "you are free little kubelet!"
      EOT

      // disk_size     = 50
      instance_type = "m5.large"

      launch_template_name            = format("%s-self-managed", local.devops_name)
      launch_template_use_name_prefix = true
      launch_template_description     = format("Self managed %s node group", local.devops_name)

      ebs_optimized          = true
      vpc_security_group_ids = [aws_security_group.additional.id]
      enable_monitoring      = true

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

      create_iam_role          = true
      iam_role_name            = format("%s-self-managed-node-group-role", local.devops_name)
      iam_role_use_name_prefix = false
      iam_role_description     = format("Self managed node group %s role", local.devops_name)
      iam_role_tags = {
        Purpose = "Protector of the kubelet"
      }
      iam_role_additional_policies = [
        "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
        "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
        "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
      ]

      create_security_group          = true
      security_group_name            = format("%s-node-group-sg", local.devops_name)
      security_group_use_name_prefix = false
      security_group_description     = format("%s node group security group", local.devops_name)
      security_group_rules = {
        phoneOut = {
          description = "Hello CloudFlare"
          protocol    = "udp"
          from_port   = 53
          to_port     = 53
          type        = "egress"
          cidr_blocks = ["1.1.1.1/32"]
        }
        phoneHome = {
          description                   = "Hello cluster"
          protocol                      = "udp"
          from_port                     = 53
          to_port                       = 53
          type                          = "egress"
          source_cluster_security_group = true # bit of reflection lookup
        }
      }
      security_group_tags = {
        Purpose = "Protector of the kubelet"
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


resource "aws_security_group" "additional" {
  #checkov:skip=CKV2_AWS_5:the resource will be used
  #ts:skip=AC_AWS_0320 skip
  name_prefix = "${local.name}-additional"
  vpc_id      = var.vpc_id
  description = "Allow inbound traffic to eks from VPC CIDR"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
      "10.0.0.0/8",
      "172.16.0.0/12",
      "192.168.0.0/16",
    ]
    description = "allow port 22"
  }

  tags = local.tags
}
#tfsec:ignore:aws-kms-auto-rotate-keys:skip key rotate
resource "aws_kms_key" "eks" {
  #checkov:skip=CKV_AWS_7:sikp
  #ts:skip=AC_AWS_0160 skip key rotate
  description             = "EKS Secret Encryption Key"
  deletion_window_in_days = 7
  enable_key_rotation     = false

  tags = local.tags
}

data "aws_ami" "eks_default" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amazon-eks-node-${local.cluster_version}-v*"]
  }
}

data "aws_ami" "eks_default_bottlerocket" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["bottlerocket-aws-k8s-${local.cluster_version}-x86_64-*"]
  }
}

resource "tls_private_key" "this" {
  algorithm = "RSA"
}

resource "aws_key_pair" "this" {
  key_name   = local.name
  public_key = tls_private_key.this.public_key_openssh
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
