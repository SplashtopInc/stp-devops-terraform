### System ###
# AWS privilege
variable "profile" {
  type    = string
  default = ""
}
variable "assume_role" {
  type    = string
  default = ""
}

variable "region" {
  type    = string
  default = ""
}

variable "project" {
  type    = string
  default = ""
}

variable "environment" {
  type    = string
  default = ""
}

variable "account" {
  type    = string
  default = ""
}
# AWS account name for SQS naming prefix (for temporary)
variable "aws_account_name" {
  type    = string
  default = ""
  # AWS account name e.g., "aws-polkast", "aws-gstun", "aws-rd", "aws-tperd" ...
}

### SSH key for worker nodes ###
variable "ssh_keypair" {
  description = "SSH key name for EC2 instance"
  type        = string
  default     = ""
}

### Certificates ###
variable "certArnDomain" {
  description = "SSL cert ARN for tier one domain, e.g. *.example.com"
  type        = string
  default     = ""
}
variable "certArnApi" {
  description = "SSL cert ARN for API tier, e.g. *.api.example.com"
  type        = string
  default     = ""
}

### Site information ###
variable "domain" {
  type    = string
  default = "splashtop.de"
}
## Passing outputs between modules
variable "vpc_id" {
  description = "vpc module outputs the ID under the name vpc_id"
  type        = string
  default     = ""
}

variable "subnets" {
  description = "vpc module outputs the pub-private-subnet ID under the name subnets"
  type        = list(string)
  default     = []
}

variable "eks_bottlerocket_enabled" { # Default "true" for Create EKS
  type    = bool
  default = true
}

variable "eks_spot_enabled" { # spot instance
  type    = bool
  default = false
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

### EKS ###
# Version
variable "eks_cluster_version" { # EKS version
  type    = string
  default = "1.21"
}

variable "enable_admin_container" {
  description = "Enable/disable admin container"
  default     = false
  type        = bool
}

variable "enable_control_container" {
  description = "Enable/disable control container"
  default     = true
  type        = bool
}
# Log retention
variable "eks_log_retention" { # EKS log retention day
  type    = number
  default = 7
}
# Customized AMI for EKS work node
variable "hardened_worker_ami_owner_id" { # Hardened AMI owner ID
  type    = string
  default = ""
}
variable "hardened_worker_ami_linux" { # Hardened Linux AMI name filter keywords
  type    = string
  default = "*GoldenAMIBase-1.0-amazon-eks-node-1.21-1"
}
variable "bottlerocket_worker_ami_owner_id" { # BottleRocket AMI owner ID
  type    = string
  default = "amazon"
}


# for EKS API public access whitelist
variable "eks_api_whitelist" {
  description = "IP whitelist for EKS API public access"
  type        = list(string)
  default     = []
}

### Work groups scaling ###
# Instance types of maximum pods list:
# https://github.com/awslabs/amazon-eks-ami/blob/master/files/eni-max-pods.txt
# BE App EKS
variable "be_eks_enabled" { # Default "true" for Create EKS
  type    = bool
  default = true
}
variable "be_eks_bottlerocket_enabled" { # Use BottleRocket?
  type    = bool
  default = false
}
# BE App - api
variable "be_api_instance_types" { # Instance type
  type = list(string)
  default = [
    "t3a.large",
    "t3.large",
    "t2.large",
    "m5a.large",
    "m5.large"
  ]
}
variable "be_api_max_size" { # Maximum size in scaling
  type    = number
  default = 5
}
variable "be_api_min_size" { # Minimum size in scaling
  type    = number
  default = 3
}
variable "be_api_desired_size" { # Desired size in scaling
  type    = number
  default = 3
}
variable "be_api_on_demand_size" { # On-demand size of work nodes
  type    = number
  default = 3
}
variable "be_api_on_demand_percentage" { # Percentage of on-demand in scaling out
  type    = number
  default = 100
}
variable "be_api_bottlerocket_labels" {
  description = "kubelet labels arguments for backend api work group"
  type        = string
  default     = ""
}
variable "be_api_bottlerocket_taints" {
  description = "kubelet taints arguments for backend api work group"
  type        = string
  default     = ""
}
variable "be_kubelet_args_api" {
  description = "kubelet arguments for backend api work group"
  type        = list(string)
  default     = []
}
# BE App - my
variable "be_my_instance_types" { # Instance type
  type    = list(string)
  default = []
}
variable "be_my_max_size" { # Maximum size in scaling
  type    = number
  default = 5
}
variable "be_my_min_size" { # Minimum size in scaling
  type    = number
  default = 3
}
variable "be_my_desired_size" { # Desired size in scaling
  type    = number
  default = 3
}
variable "be_my_on_demand_size" { # On-demand size of work nodes
  type    = number
  default = 3
}
variable "be_my_on_demand_percentage" { # Percentage of on-demand in scaling out
  type    = number
  default = 100
}
variable "be_my_bottlerocket_labels" {
  description = "kubelet labels arguments for backend api work group"
  type        = string
  default     = ""
}
variable "be_my_bottlerocket_taints" {
  description = "kubelet taints arguments for backend api work group"
  type        = string
  default     = ""
}
variable "be_kubelet_args_my" {
  description = "kubelet arguments for backend my work group"
  type        = list(string)
  default     = []
}
# BE App - devops
variable "be_devops_instance_types" { # Instance type
  type    = list(string)
  default = []
}
variable "be_devops_max_size" { # Maximum size in scaling
  type    = number
  default = 5
}
variable "be_devops_min_size" { # Minimum size in scaling
  type    = number
  default = 3
}
variable "be_devops_desired_size" { # Desired size in scaling
  type    = number
  default = 3
}
variable "be_devops_on_demand_size" { # On-demand size of work nodes
  type    = number
  default = 3
}
variable "be_devops_on_demand_percentage" { # Percentage of on-demand in scaling out
  type    = number
  default = 100
}
variable "be_devops_bottlerocket_labels" {
  description = "kubelet labels arguments for backend api work group"
  type        = string
  default     = ""
}
variable "be_devops_bottlerocket_taints" {
  description = "kubelet taints arguments for backend api work group"
  type        = string
  default     = ""
}
variable "be_kubelet_args_devops" {
  description = "kubelet arguments for backend devops work group"
  type        = list(string)
  default     = []
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

### RBAC ###
variable "map_accounts" {
  description = "Additional AWS account numbers to add to the aws-auth configmap."
  type        = list(string)

  default = [
    "777777777777",
    "888888888888",
  ]
}
variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      rolearn  = "arn:aws:iam::66666666666:role/role1"
      username = "role1"
      groups   = ["system:masters"]
    },
  ]
}
variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      userarn  = "arn:aws:iam::66666666666:user/user1"
      username = "user1"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::66666666666:user/user2"
      username = "user2"
      groups   = ["system:masters"]
    },
  ]
}
