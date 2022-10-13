# AWS privilege
variable "assume_role" {
  description = "the aws role to be assigned to"
  type        = string
  default     = ""
}

variable "region" {
  description = "the aws region"
  type        = string
  default     = ""
}

variable "project" {
  description = "the project name"
  type        = string
  default     = ""
}

variable "environment" {
  description = "the environment ex: prod, qa, test"
  type        = string
  default     = ""
}

### VPCs ###
variable "name" {
  type    = string
  default = "stp-vpc-pub"
}
variable "vpc_pub_az_start" {
  type    = number
  default = 0
}
variable "vpc_pub_az_end" {
  type    = number
  default = 3
}
# Public
variable "vpc_pub_cidr" {
  type    = string
  default = "172.26.0.0/16"
}
variable "vpc_pub_pri_subnets" {
  type = list(string)
  default = [
    "172.26.16.0/23",
    "172.26.18.0/23",
    "172.26.20.0/23"
  ]
}
variable "vpc_pub_pub_subnets" {
  type = list(string)
  default = [
    "172.26.0.0/23",
    "172.26.2.0/23",
    "172.26.4.0/23",
    "172.26.6.0/23",
    "172.26.8.0/23",
    "172.26.10.0/23"
  ]
}

variable "vpc_pub_reuse_nat_ips" {
  type    = bool
  default = false
}

variable "vpc_pub_nat_eip_ids" {
  type = list(string)
  default = [
    "eipalloc-xxxxxxxxxxxxxxxxx",
    "eipalloc-xxxxxxxxxxxxxxxxx",
    "eipalloc-xxxxxxxxxxxxxxxxx"
  ]
}

### SG whitelist ###
# for PRODUCTION beta-my ALB
variable "sg_whitelist_ips_office_production" {
  description = "IP whitelist of office HTTPS/HTTP traffic for PRODUCTION"
  type = list(object({
    desc        = string
    cidr_blocks = string
  }))

  default = []
}
# for NON-PRODUCTION ALL ALB
variable "sg_whitelist_ips_office_nonprod_http" {
  description = "IP whitelist of office HTTP traffic for NON-PRODUCTION"
  type = list(object({
    desc        = string
    cidr_blocks = string
  }))

  default = []
}
variable "sg_whitelist_ips_office_nonprod_https" {
  description = "IP whitelist of office HTTPS traffic for NON-PRODUCTION"
  type = list(object({
    desc        = string
    cidr_blocks = string
  }))

  default = []
}
variable "sg_whitelist_ips_outside_nonprod_https" {
  description = "IP whitelist of outside HTTPS traffic for NON-PRODUCTION"
  type = list(object({
    desc        = string
    cidr_blocks = string
  }))

  default = []
}

