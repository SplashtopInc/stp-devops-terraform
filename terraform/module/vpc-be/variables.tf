### provider ###

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
####################
# Backend
variable "create_vpc" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable "name" {
  description = "vpc name"
  type        = string
  default     = "stp-vpc-backend"
}

variable "vpc_backend_az_start" {
  type    = number
  default = 0
}

variable "vpc_backend_az_end" {
  type    = number
  default = 3
}

variable "vpc_backend_cidr" {
  type    = string
  default = "10.21.0.0/16"
}
variable "vpc_backend_pri_subnets" {
  type = list(string)
  default = [
    "10.21.18.0/23",
    "10.21.20.0/23"
  ]
}
variable "vpc_backend_pub_subnets" {
  type = list(string)
  default = [
    "10.21.2.0/23",
    "10.21.10.0/23"
  ]
}

variable "vpc_backend_reuse_nat_ips" {
  type    = bool
  default = false
}

variable "vpc_backend_nat_eip_ids" {
  type    = list(string)
  default = []
  // "eipalloc-xxxxxxxxxxxxxxxxx",
  // "eipalloc-xxxxxxxxxxxxxxxxx"
}

### Site information ###
variable "domain" {
  type    = string
  default = "splashtop.de"
}