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
variable "name" {
  type    = string
  default = "stp-vpc-project"
}

variable "vpc_az_start" {
  type    = number
  default = 0
}

variable "vpc_az_end" {
  type    = number
  default = 3
}

variable "vpc_cidr" {
  type    = string
  default = "10.117.0.0/16"
}
variable "vpc_pri_subnets" {
  type = list(string)
  default = [
    "10.117.0.0/24"
  ]
}
variable "vpc_pub_subnets" {
  type = list(string)
  default = [
    "10.117.1.0/24"
  ]
}

variable "vpc_database_subnets" {
  type = list(string)
  default = [
    "10.117.100.0/24"
  ]
}

variable "create_database_subnet_group" {
  type    = bool
  default = false
}

variable "vpc_reuse_nat_ips" {
  type    = bool
  default = false
}

variable "vpc_nat_eip_ids" {
  type    = list(string)
  default = []
  // "eipalloc-xxxxxxxxxxxxxxxxx",
  // "eipalloc-xxxxxxxxxxxxxxxxx"
}
