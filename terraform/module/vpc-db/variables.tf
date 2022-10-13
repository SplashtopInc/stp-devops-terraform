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

### VPCs ###
# DB
variable "name" {
  type    = string
  default = "stp-vpc-db"
}

variable "vpc_db_az_start" {
  type    = number
  default = 0
}
variable "vpc_db_az_end" {
  type    = number
  default = 3
}
variable "vpc_db_cidr" {
  type    = string
  default = "10.20.0.0/16"
}
variable "vpc_db_pri_subnets" {
  type = list(string)
  default = [
    "10.20.18.0/24",
    "10.20.10.0/24"
  ]
}
variable "vpc_db_pub_subnets" {
  type = list(string)
  default = [
    "10.20.2.0/24",
    "10.20.20.0/24"
  ]
}

