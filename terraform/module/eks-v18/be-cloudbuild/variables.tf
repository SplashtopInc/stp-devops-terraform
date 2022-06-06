variable "create" {
  description = "Controls if EKS resources should be created (affects nearly all resources)"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "prefix_separator" {
  description = "The separator to use between the prefix and the generated timestamp for resource names"
  type        = string
  default     = "-"
}

################################################################################
# Cluster
################################################################################

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = ""
}

variable "cluster_version" {
  description = "Kubernetes `<major>.<minor>` version to use for the EKS cluster (i.e.: `1.21`)"
  type        = string
  default     = null
}

variable "cluster_enabled_log_types" {
  description = "A list of the desired control plane logs to enable. For more information, see Amazon EKS Control Plane Logging documentation (https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html)"
  type        = list(string)
  default     = ["audit", "api", "authenticator"]
}

variable "cluster_additional_security_group_ids" {
  description = "List of additional, externally created security group IDs to attach to the cluster control plane"
  type        = list(string)
  default     = []
}

variable "subnet_ids" {
  description = "A list of subnet IDs where the EKS cluster (ENIs) will be provisioned along with the nodes/node groups. Node groups can be deployed within a different set of subnet IDs from within the node group configuration"
  type        = list(string)
  default     = []
}

variable "cluster_endpoint_private_access" {
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled"
  type        = bool
  default     = false
}

variable "cluster_endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled"
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "List of CIDR blocks which can access the Amazon EKS public API server endpoint"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "cluster_ip_family" {
  description = "The IP family used to assign Kubernetes pod and service addresses. Valid values are `ipv4` (default) and `ipv6`. You can only specify an IP family when you create a cluster, changing this value will force a new cluster to be created"
  type        = string
  default     = null
}

variable "cluster_service_ipv4_cidr" {
  description = "The CIDR block to assign Kubernetes service IP addresses from. If you don't specify a block, Kubernetes assigns addresses from either the 10.100.0.0/16 or 172.20.0.0/16 CIDR blocks"
  type        = string
  default     = null
}

variable "cluster_encryption_config" {
  description = "Configuration block with encryption configuration for the cluster"
  type = list(object({
    provider_key_arn = string
    resources        = list(string)
  }))
  default = []
}

variable "attach_cluster_encryption_policy" {
  description = "Indicates whether or not to attach an additional policy for the cluster IAM role to utilize the encryption key provided"
  type        = bool
  default     = true
}

variable "cluster_tags" {
  description = "A map of additional tags to add to the cluster"
  type        = map(string)
  default     = {}
}

variable "cluster_timeouts" {
  description = "Create, update, and delete timeout configurations for the cluster"
  type        = map(string)
  default     = {}
}

################################################################################
# CloudWatch Log Group
################################################################################

variable "create_cloudwatch_log_group" {
  description = "Determines whether a log group is created by this module for the cluster logs. If not, AWS will automatically create one if logging is enabled"
  type        = bool
  default     = true
}

variable "cloudwatch_log_group_retention_in_days" {
  description = "Number of days to retain log events. Default retention - 90 days"
  type        = number
  default     = 90
}

variable "cloudwatch_log_group_kms_key_id" {
  description = "If a KMS Key ARN is set, this key will be used to encrypt the corresponding log group. Please be sure that the KMS Key has an appropriate key policy (https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/encrypt-log-data-kms.html)"
  type        = string
  default     = null
}

################################################################################
# Cluster Security Group
################################################################################

variable "create_cluster_security_group" {
  description = "Determines if a security group is created for the cluster or use the existing `cluster_security_group_id`"
  type        = bool
  default     = true
}

variable "cluster_security_group_id" {
  description = "Existing security group ID to be attached to the cluster. Required if `create_cluster_security_group` = `false`"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "ID of the VPC where the cluster and its nodes will be provisioned"
  type        = string
  default     = null
}

variable "cluster_security_group_name" {
  description = "Name to use on cluster security group created"
  type        = string
  default     = null
}

variable "cluster_security_group_use_name_prefix" {
  description = "Determines whether cluster security group name (`cluster_security_group_name`) is used as a prefix"
  type        = string
  default     = true
}

variable "cluster_security_group_description" {
  description = "Description of the cluster security group created"
  type        = string
  default     = "EKS cluster security group"
}

variable "cluster_security_group_additional_rules" {
  description = "List of additional security group rules to add to the cluster security group created. Set `source_node_security_group = true` inside rules to set the `node_security_group` as source"
  type        = any
  default     = {}
}

variable "cluster_security_group_tags" {
  description = "A map of additional tags to add to the cluster security group created"
  type        = map(string)
  default     = {}
}

################################################################################
# EKS IPV6 CNI Policy
################################################################################

variable "create_cni_ipv6_iam_policy" {
  description = "Determines whether to create an [`AmazonEKS_CNI_IPv6_Policy`](https://docs.aws.amazon.com/eks/latest/userguide/cni-iam-role.html#cni-iam-role-create-ipv6-policy)"
  type        = bool
  default     = false
}

################################################################################
# Node Security Group
################################################################################

variable "create_node_security_group" {
  description = "Determines whether to create a security group for the node groups or use the existing `node_security_group_id`"
  type        = bool
  default     = true
}

variable "node_security_group_id" {
  description = "ID of an existing security group to attach to the node groups created"
  type        = string
  default     = ""
}

variable "node_security_group_name" {
  description = "Name to use on node security group created"
  type        = string
  default     = null
}

variable "node_security_group_use_name_prefix" {
  description = "Determines whether node security group name (`node_security_group_name`) is used as a prefix"
  type        = string
  default     = true
}

variable "node_security_group_description" {
  description = "Description of the node security group created"
  type        = string
  default     = "EKS node shared security group"
}

variable "node_security_group_additional_rules" {
  description = "List of additional security group rules to add to the node security group created. Set `source_cluster_security_group = true` inside rules to set the `cluster_security_group` as source"
  type        = any
  default     = {}
}

variable "node_security_group_tags" {
  description = "A map of additional tags to add to the node security group created"
  type        = map(string)
  default     = {}
}

################################################################################
# IRSA
################################################################################

variable "enable_irsa" {
  description = "Determines whether to create an OpenID Connect Provider for EKS to enable IRSA"
  type        = bool
  default     = true
}

variable "openid_connect_audiences" {
  description = "List of OpenID Connect audience client IDs to add to the IRSA provider"
  type        = list(string)
  default     = []
}

variable "custom_oidc_thumbprints" {
  description = "Additional list of server certificate thumbprints for the OpenID Connect (OIDC) identity provider's server certificate(s)"
  type        = list(string)
  default     = []
}

################################################################################
# Cluster IAM Role
################################################################################

variable "create_iam_role" {
  description = "Determines whether a an IAM role is created or to use an existing IAM role"
  type        = bool
  default     = true
}

variable "iam_role_arn" {
  description = "Existing IAM role ARN for the cluster. Required if `create_iam_role` is set to `false`"
  type        = string
  default     = null
}

variable "iam_role_name" {
  description = "Name to use on IAM role created"
  type        = string
  default     = null
}

variable "iam_role_use_name_prefix" {
  description = "Determines whether the IAM role name (`iam_role_name`) is used as a prefix"
  type        = string
  default     = true
}

variable "iam_role_path" {
  description = "Cluster IAM role path"
  type        = string
  default     = null
}

variable "iam_role_description" {
  description = "Description of the role"
  type        = string
  default     = null
}

variable "iam_role_permissions_boundary" {
  description = "ARN of the policy that is used to set the permissions boundary for the IAM role"
  type        = string
  default     = null
}

variable "iam_role_additional_policies" {
  description = "Additional policies to be added to the IAM role"
  type        = list(string)
  default     = []
}

# TODO - hopefully this can be removed once the AWS endpoint is named properly in China
# https://github.com/terraform-aws-modules/terraform-aws-eks/issues/1904
variable "cluster_iam_role_dns_suffix" {
  description = "Base DNS domain name for the current partition (e.g., amazonaws.com in AWS Commercial, amazonaws.com.cn in AWS China)"
  type        = string
  default     = null
}

variable "iam_role_tags" {
  description = "A map of additional tags to add to the IAM role created"
  type        = map(string)
  default     = {}
}

variable "cluster_encryption_policy_use_name_prefix" {
  description = "Determines whether cluster encryption policy name (`cluster_encryption_policy_name`) is used as a prefix"
  type        = string
  default     = true
}

variable "cluster_encryption_policy_name" {
  description = "Name to use on cluster encryption policy created"
  type        = string
  default     = null
}

variable "cluster_encryption_policy_description" {
  description = "Description of the cluster encryption policy created"
  type        = string
  default     = "Cluster encryption policy to allow cluster role to utilize CMK provided"
}

variable "cluster_encryption_policy_path" {
  description = "Cluster encryption policy path"
  type        = string
  default     = null
}

variable "cluster_encryption_policy_tags" {
  description = "A map of additional tags to add to the cluster encryption policy created"
  type        = map(string)
  default     = {}
}

################################################################################
# EKS Addons
################################################################################

variable "cluster_addons" {
  description = "Map of cluster addon configurations to enable for the cluster. Addon name can be the map keys or set with `name`"
  type        = any
  default     = {}
}

################################################################################
# EKS Identity Provider
################################################################################

variable "cluster_identity_providers" {
  description = "Map of cluster identity provider configurations to enable for the cluster. Note - this is different/separate from IRSA"
  type        = any
  default     = {}
}

################################################################################
# Fargate
################################################################################

variable "fargate_profiles" {
  description = "Map of Fargate Profile definitions to create"
  type        = any
  default     = {}
}

variable "fargate_profile_defaults" {
  description = "Map of Fargate Profile default configurations"
  type        = any
  default     = {}
}

################################################################################
# Self Managed Node Group
################################################################################

variable "self_managed_node_groups" {
  description = "Map of self-managed node group definitions to create"
  type        = any
  default     = {}
}

variable "self_managed_node_group_defaults" {
  description = "Map of self-managed node group default configurations"
  type        = any
  default     = {}
}

variable "platform" {
  description = "Identifies if the OS platform is `bottlerocket`, `linux`, or `windows` based"
  type        = string
  default     = "linux"
}

################################################################################
# EKS Managed Node Group
################################################################################

variable "eks_managed_node_groups" {
  description = "Map of EKS managed node group definitions to create"
  type        = any
  default     = {}
}

variable "eks_managed_node_group_defaults" {
  description = "Map of EKS managed node group default configurations"
  type        = any
  default     = {}
}

variable "putin_khuylo" {
  description = "Do you agree that Putin doesn't respect Ukrainian sovereignty and territorial integrity? More info: https://en.wikipedia.org/wiki/Putin_khuylo!"
  type        = bool
  default     = true
}

################################################################################
# Terragrunt input aws variable
################################################################################
variable "profile" {
  type    = string
  default = "(Optional) AWS profile name as set in the shared configuration and credentials files. Can also be set using either the environment variables AWS_PROFILE or AWS_DEFAULT_PROFILE."
}
variable "assume_role" {
  type    = string
  default = "(Optional) Configuration block for assuming an IAM role. See the assume_role Configuration Block section below. Only one assume_role block may be in the configuration."
}

variable "region" {
  type    = string
  default = "(Optional) The AWS region where the provider will operate. The region must be set. Can also be set with either the AWS_REGION or AWS_DEFAULT_REGION environment variables, or via a shared config file parameter region if profile is used. If credentials are retrieved from the EC2 Instance Metadata Service, the region can also be retrieved from the metadata."
}

variable "project" {
  type    = string
  default = "(Optional) The project of eks"
}

variable "environment" {
  type    = string
  default = "(Optional) The environment of eks"
}

variable "account" {
  type    = string
  default = "(Optional) The ID of the target account when managing member accounts. "
}

variable "aws_account_name" {
  type    = string
  default = "(Optional) The name of the AWS account"
}

variable "eks_spot_enabled" {
  description = "spot setting on self_managed_node_groups"
  type        = bool
  default     = false
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = []
}
variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))

  default = []
}

################################################################################
# others
################################################################################
variable "cb_others_instance_types" {
  description = "(Optional) List of instance types associated with the EKS Node Group."
  type        = list(object({ instance_type = string }))
  default = [
    {
      instance_type = "m5.large"
    },
    {
      instance_type = "m4.large"
    },
    {
      instance_type = "t3.large"
    },
    {
      instance_type = "t2.large"
    }
  ]
}
variable "cb_others_max_size" {
  description = "(Required) The maximum size of the Auto Scaling Group."
  type        = number
  default     = 5
}
variable "cb_others_min_size" {
  description = "(Required) The minimum size of the Auto Scaling Group"
  type        = number
  default     = 3
}
variable "cb_others_desired_size" {
  description = "The number of Amazon EC2 instances that should be running in the autoscaling group"
  type        = number
  default     = 3
}
variable "cb_others_on_demand_base_capacity" {
  description = "(Optional) Absolute minimum amount of desired capacity that must be fulfilled by on-demand instances. Default: 0"
  type        = number
  default     = 0
}
variable "cb_others_on_demand_percentage" { # Percentage of on-demand in scaling out
  type        = number
  default     = 100
  description = "(Optional) Percentage split between on-demand and Spot instances above the base on-demand capacity. Default: 100"
}
variable "cb_kubelet_args_others" {
  description = "kubelet arguments for other work group"
  type        = string
  default     = ""
}
################################################################################
# wine
################################################################################
variable "cb_wine_instance_types" {
  description = "(Optional) List of instance types associated with the EKS Node Group."
  type        = list(object({ instance_type = string }))
  default = [
    {
      instance_type = "m5.large"
    },
    {
      instance_type = "m4.large"
    },
    {
      instance_type = "t3.large"
    },
    {
      instance_type = "t2.large"
    }
  ]
}
variable "cb_wine_max_size" {
  description = "(Required) The maximum size of the Auto Scaling Group."
  type        = number
  default     = 5
}
variable "cb_wine_min_size" {
  description = "(Required) The minimum size of the Auto Scaling Group"
  type        = number
  default     = 3
}
variable "cb_wine_desired_size" {
  description = "The number of Amazon EC2 instances that should be running in the autoscaling group"
  type        = number
  default     = 3
}
variable "cb_wine_on_demand_base_capacity" {
  description = "(Optional) Absolute minimum amount of desired capacity that must be fulfilled by on-demand instances. Default: 0"
  type        = number
  default     = 0
}
variable "cb_wine_on_demand_percentage" {
  type        = number
  default     = 100
  description = "(Optional) Percentage split between on-demand and Spot instances above the base on-demand capacity. Default: 100"
}
variable "cb_kubelet_args_wine" {
  description = "kubelet arguments for wine work group"
  type        = string
  default     = ""
}
################################################################################
# devops
################################################################################
variable "cb_devops_instance_types" {
  description = "(Optional) List of instance types associated with the EKS Node Group."
  type        = list(object({ instance_type = string }))
  default = [
    {
      instance_type = "m5.large"
    },
    {
      instance_type = "m4.large"
    },
    {
      instance_type = "t3.large"
    },
    {
      instance_type = "t2.large"
    }
  ]
}
variable "cb_devops_max_size" {
  description = "(Required) The maximum size of the Auto Scaling Group."
  type        = number
  default     = 5
}
variable "cb_devops_min_size" {
  description = "(Required) The minimum size of the Auto Scaling Group"
  type        = number
  default     = 1
}
variable "cb_devops_desired_size" {
  description = "The number of Amazon EC2 instances that should be running in the autoscaling group"
  type        = number
  default     = 1
}
variable "cb_devops_on_demand_base_capacity" {
  description = "(Optional) Absolute minimum amount of desired capacity that must be fulfilled by on-demand instances. Default: 0"
  type        = number
  default     = 0
}
variable "cb_devops_on_demand_percentage" { # Percentage of on-demand in scaling out
  description = "(Optional) Percentage split between on-demand and Spot instances above the base on-demand capacity. Default: 100"
  type        = number
  default     = 100
}
variable "cb_kubelet_args_devops" {
  description = "kubelet arguments for devops work group"
  type        = string
  default     = ""
}
### Services name ###
variable "app_service" {
  type    = string
  default = "app"
}
variable "mymail_service" {
  type    = string
  default = "my-mail"
}
variable "cloudbuild_service" {
  type    = string
  default = "cloudbuild"
}
variable "relayfe_service" {
  type    = string
  default = "relay-fe-17"
}
variable "relayrs_service" {
  type    = string
  default = "relay-rs-17"
}
# Customized AMI for EKS work node
variable "hardened_worker_ami_owner_id" {
  description = "The AMI from which to launch the instance"
  type        = string
  default     = ""
}
variable "hardened_worker_ami_linux" {
  description = "The AMI from which to launch the instance"
  type        = string
  default     = ""
}
### CloudFront Distributions ###
variable "cloudfront_dist_id_g2" {
  type    = string
  default = "XXXXXXX"
}
variable "cloudfront_dist_id_g3" {
  type    = string
  default = "XXXXXXX"
}