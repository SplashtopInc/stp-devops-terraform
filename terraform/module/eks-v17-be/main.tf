module "eks-be" {
  source  = "terraform-aws-modules/eks/aws"
  version = "17.22.0"

  create_eks = var.be_eks_enabled

  providers = {
    kubernetes = kubernetes.k8s-beapp
  }

  vpc_id  = (var.vpc_id != "" ? var.vpc_id : data.aws_vpc.stp-vpc-pub.id)
  subnets = (var.subnets != "" ? var.subnets : data.aws_subnet_ids.stp-vpc-pub-private.ids)

  cluster_name    = local.app_cluster_name
  cluster_version = var.eks_cluster_version

  cluster_endpoint_private_access      = true
  cluster_endpoint_public_access       = true
  cluster_endpoint_public_access_cidrs = var.eks_api_whitelist

  cluster_log_retention_in_days = var.eks_log_retention
  cluster_enabled_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  tags = {
    Project     = var.project
    Service     = var.app_service
    Environment = var.environment
  }

  worker_groups_launch_template = [
    {
      name = "api"

      subnets = data.aws_subnet_ids.stp-vpc-pub-private.ids

      ami_id                 = data.aws_ami.beapp_node_ami.id
      userdata_template_file = local.be_userdata_template_file
      userdata_template_extra_args = {
        enable_admin_container   = false
        enable_control_container = true
        aws_region               = var.region
      }
      # k8s/kubelet configuration via additional_userdata for BottleRocket
      # https://github.com/bottlerocket-os/bottlerocket#kubernetes-settings
      additional_userdata = <<EOT
%{if var.be_eks_bottlerocket_enabled}
[settings.kubernetes.node-taints]
${var.be_api_bottlerocket_taints}
[settings.kubernetes.node-labels]
${var.be_api_bottlerocket_labels}
%{endif}
EOT

      override_instance_types                  = var.be_api_instance_types
      asg_max_size                             = var.be_api_max_size
      asg_min_size                             = var.be_api_min_size
      asg_desired_capacity                     = var.be_api_desired_size
      on_demand_base_capacity                  = var.be_api_on_demand_size       # same as min_size for production, 0 for non-production
      on_demand_percentage_above_base_capacity = var.be_api_on_demand_percentage # 100 for production, 0 for non-prod, percentage above base capacity, 1 in 4 of new nodes will be one on-demand instance if set to 25
      spot_allocation_strategy                 = "capacity-optimized"            # "capacity-optimized" for all, default "lowest-price"
      spot_instance_pools                      = 0                               # 0 for all (only for "lowest-price"), default 10
      kubelet_extra_args                       = join(" ", var.be_kubelet_args_api)
      public_ip                                = false
      key_name                                 = var.ssh_keypair
      platform                                 = "linux"     # e.g., "linux", "windows"
      termination_policies                     = ["Default"] # https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-instance-termination.html

      # EBS
      root_volume_type = "gp3"
      root_volume_size = "50"
      root_encrypted   = true

      ## Warm pool
      #warm_pool = [
      #  {
      #    pool_state                  = null
      #    min_size                    = null
      #    max_group_prepared_capacity = null
      #  }
      #]

      tags = [
        {
          "key"                 = "k8s.io/cluster-autoscaler/${module.eks-be.cluster_id}"
          "value"               = "owned"
          "propagate_at_launch" = false
        },
        {
          "key"                 = "k8s.io/cluster-autoscaler/enabled"
          "value"               = "true"
          "propagate_at_launch" = false
        }
      ]
    },
    {
      name = "my"

      subnets = data.aws_subnet_ids.stp-vpc-pub-private.ids

      ami_id                 = data.aws_ami.beapp_node_ami.id
      userdata_template_file = local.be_userdata_template_file
      userdata_template_extra_args = {
        enable_admin_container   = false
        enable_control_container = true
        aws_region               = var.region
      }
      # k8s/kubelet configuration via additional_userdata for BottleRocket
      # https://github.com/bottlerocket-os/bottlerocket#kubernetes-settings
      additional_userdata = <<EOT
%{if var.be_eks_bottlerocket_enabled}
[settings.kubernetes.node-taints]
${var.be_my_bottlerocket_taints}
[settings.kubernetes.node-labels]
${var.be_my_bottlerocket_labels}
%{endif}
EOT

      override_instance_types                  = var.be_my_instance_types
      asg_max_size                             = var.be_my_max_size
      asg_min_size                             = var.be_my_min_size
      asg_desired_capacity                     = var.be_my_desired_size
      on_demand_base_capacity                  = var.be_my_on_demand_size       # same as min_size for production, 0 for non-production
      on_demand_percentage_above_base_capacity = var.be_my_on_demand_percentage # 100 for production, 0 for non-prod, percentage above base capacity, 1 in 4 of new nodes will be one on-demand instance if set to 25
      spot_allocation_strategy                 = "capacity-optimized"           # "capacity-optimized" for all, default "lowest-price"
      spot_instance_pools                      = 0                              # 0 for all (only for "lowest-price"), default 10
      kubelet_extra_args                       = join(" ", var.be_kubelet_args_my)
      public_ip                                = false
      key_name                                 = var.ssh_keypair
      platform                                 = "linux"     # e.g., "linux", "windows"
      termination_policies                     = ["Default"] # https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-instance-termination.html

      # EBS
      root_volume_type = "gp3"
      root_volume_size = "50"
      root_encrypted   = true

      ## Warm pool
      #warm_pool = [
      #  {
      #    pool_state                  = null
      #    min_size                    = null
      #    max_group_prepared_capacity = null
      #  }
      #]

      tags = [
        {
          "key"                 = "k8s.io/cluster-autoscaler/${module.eks-be.cluster_id}"
          "value"               = "owned"
          "propagate_at_launch" = false
        },
        {
          "key"                 = "k8s.io/cluster-autoscaler/enabled"
          "value"               = "true"
          "propagate_at_launch" = false
        }
      ]
    },
    {
      name = "devops"

      subnets = data.aws_subnet_ids.stp-vpc-pub-private.ids

      ami_id                 = data.aws_ami.beapp_node_ami.id
      userdata_template_file = local.be_userdata_template_file
      userdata_template_extra_args = {
        enable_admin_container   = false
        enable_control_container = true
        aws_region               = var.region
      }
      # k8s/kubelet configuration via additional_userdata for BottleRocket
      # https://github.com/bottlerocket-os/bottlerocket#kubernetes-settings
      additional_userdata = <<EOT
%{if var.be_eks_bottlerocket_enabled}
[settings.kubernetes.node-taints]
${var.be_devops_bottlerocket_taints}
[settings.kubernetes.node-labels]
${var.be_devops_bottlerocket_labels}
%{endif}
EOT

      override_instance_types                  = var.be_devops_instance_types
      asg_max_size                             = var.be_devops_max_size
      asg_min_size                             = var.be_devops_min_size
      asg_desired_capacity                     = var.be_devops_desired_size
      on_demand_base_capacity                  = var.be_devops_on_demand_size       # same as min_size for production, 0 for non-production
      on_demand_percentage_above_base_capacity = var.be_devops_on_demand_percentage # 100 for production, 0 for non-prod, percentage above base capacity, 1 in 4 of new nodes will be one on-demand instance if set to 25
      spot_allocation_strategy                 = "capacity-optimized"               # "capacity-optimized" for all, default "lowest-price"
      spot_instance_pools                      = 0                                  # 0 for all (only for "lowest-price"), default 10
      kubelet_extra_args                       = join(" ", var.be_kubelet_args_devops)
      public_ip                                = false
      key_name                                 = var.ssh_keypair
      platform                                 = "linux"     # e.g., "linux", "windows"
      termination_policies                     = ["Default"] # https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-instance-termination.html

      # EBS
      root_volume_type = "gp3"
      root_volume_size = "50"
      root_encrypted   = true

      ## Warm pool
      #warm_pool = [
      #  {
      #    pool_state                  = null
      #    min_size                    = null
      #    max_group_prepared_capacity = null
      #  }
      #]

      tags = [
        {
          "key"                 = "k8s.io/cluster-autoscaler/${module.eks-be.cluster_id}"
          "value"               = "owned"
          "propagate_at_launch" = false
        },
        {
          "key"                 = "k8s.io/cluster-autoscaler/enabled"
          "value"               = "true"
          "propagate_at_launch" = false
        }
      ]
    }
  ]

  map_roles    = var.map_roles
  map_users    = var.map_users
  map_accounts = var.map_accounts
}