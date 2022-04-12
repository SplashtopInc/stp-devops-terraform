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

### SG whitelist ###
variable "sg_whitelist_ips" {
  type = list(string)
  default = [
    "44.233.246.210/32",  # James gstun-ctrl
    "74.203.89.92/32",    # James office 1
    "104.128.103.242/32", # James office 2
    "75.61.103.188/32",   # SJC office 1
    "50.193.44.33/32",    # SJC office 2
    "122.224.111.100/32", # HGH office
    "211.23.144.132/32",  # TPE office 1
    "61.31.169.172/32"    # TPE office 2
  ]
}

### Site information ###
variable "domain" {
  type    = string
  default = "splashtop.de"
}