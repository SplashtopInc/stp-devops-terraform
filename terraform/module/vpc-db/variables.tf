
# AWS account name for SQS naming prefix (for temporary)
variable "aws_account_name" {
  type    = string
  default = ""
}

variable "assume_role" {
  type    = string
  default = ""
}

variable "profile" {
  type    = string
  default = ""
}

### Site information ###
variable "domain" {
  type    = string
  default = "splashtop.de"
}
variable "region" {
  type    = string
  default = "us-west-2"
}
variable "environment" {
  type    = string
  default = ""
}
variable "project" {
  type    = string
  default = ""
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

