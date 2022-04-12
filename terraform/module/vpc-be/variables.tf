### provider ###

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
####################
# Backend
variable "name" {
  type    = string
  default = "stp-vpc-backend"
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