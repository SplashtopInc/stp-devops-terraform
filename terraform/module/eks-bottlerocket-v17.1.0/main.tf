#tfsec:ignore:aws-autoscaling-enforce-http-token-imds:
module "eks-bottlerocket" {
  source  = "terraform-aws-modules/eks/aws"
  version = "17.1.0"

  create_eks = var.eks_bottlerocket_enabled

  providers = {
    kubernetes = kubernetes.k8s-bottlerocket
  }

  vpc_id  = var.vpc_id
  subnets = var.subnets

  cluster_name    = local.bottlerocket_cluster_name
  cluster_version = var.k8s_version

  tags = {
    Project     = var.project
    Service     = var.app_service
    Environment = var.environment
  }

  cluster_endpoint_private_access      = true
  cluster_endpoint_public_access       = true
  cluster_endpoint_public_access_cidrs = var.sg_whitelist_ips

  cluster_log_retention_in_days = var.eks_log_retention
  cluster_enabled_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]
  // https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/examples/launch_templates_with_managed_node_groups/main.tf
  node_groups = {
    sonarqube = {
      name             = "sonarqube"
      ami_id           = data.aws_ami.bottlerocket_ami.id
      desired_capacity = 1
      max_capacity     = 3
      min_capacity     = 1

      create_launch_template = true
      disk_size              = 200
      disk_type              = "gp3"
      disk_throughput        = 300
      enable_monitoring      = true

      instance_type = var.sonarqube_instance_types

      k8s_labels = {
        Project     = var.project
        Service     = var.app_service
        Environment = var.environment
        sonarqube   = true
      }
      taints = [
        {
          key    = "sonarqube"
          value  = "true"
          effect = "NO_SCHEDULE"
        }
      ]
    }

    influxdb = {
      name             = "influxdb"
      ami_id           = data.aws_ami.bottlerocket_ami.id
      desired_capacity = 1
      max_capacity     = 3
      min_capacity     = 1

      create_launch_template = true
      disk_size              = 20
      disk_type              = "gp3"
      disk_throughput        = 300
      enable_monitoring      = true

      instance_type = ["t3a.medium", "t3.medium"]
      k8s_labels = {
        Project     = var.project
        Service     = var.app_service
        Environment = var.environment
        influxdb    = true
      }
      taints = [
        {
          key    = "influxdb"
          value  = "true"
          effect = "NO_SCHEDULE"
        }
      ]
    }
  }
  # https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/examples/launch_templates/main.tf
  worker_groups_launch_template = [
    {
      name = var.eks_spot_enabled ? "spot-1" : "runner-1"
      # passing bottlerocket ami id
      ami_id = data.aws_ami.bottlerocket_ami.id

      # instance_type        = var.node_instance_type
      override_instance_types = var.override_instance_types

      root_volume_size       = 200
      root_volume_type       = "gp3"
      root_volume_throughput = 300
      additional_ebs_volumes = [
        {
          block_device_name = "/dev/xvdb"
          volume_size       = 100
          volume_type       = "gp3"
          throughput        = 300
        },
      ]

      asg_max_size            = var.node_max_size
      asg_min_size            = var.node_min_size
      asg_desired_capacity    = var.node_desired_size
      on_demand_base_capacity = var.node_on_demand_size

      key_name = var.ssh_keypair
      # spot settings
      spot_instance_pools = var.eks_spot_enabled ? 4 : null
      kubelet_extra_args  = var.eks_spot_enabled ? "--node-labels=node.kubernetes.io/lifecycle=spot" : null

      # Since we are using default VPC there is no NAT gateway so we need to
      # attach public ip to nodes so they can reach k8s API server
      # do not repeat this at home (i.e. production)
      public_ip = false

      # This section overrides default userdata template to pass bottlerocket
      # specific user data
      userdata_template_file = "${path.module}/userdata.toml"
      # we are using this section to pass additional arguments for
      # userdata template rendering
      userdata_template_extra_args = {
        enable_admin_container   = var.enable_admin_container
        enable_control_container = var.enable_control_container
        aws_region               = var.region
      }
      # example of k8s/kubelet configuration via additional_userdata
      additional_userdata = <<EOT
[settings.kubernetes.node-labels]
ingress = "allowed"
EOT
      tags = [
        {
          "key"                 = "k8s.io/cluster-autoscaler/${module.eks-bottlerocket.cluster_id}"
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