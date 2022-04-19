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

// variable "environment" {
//   type    = string
//   default = ""
// }

// variable "name" {
//   type    = string
//   default = "MyProduct"
// }

variable "vpc_id" {
  type    = string
  default = ""
}

variable "private_subnet_ids" {
  type    = list(string)
  default = []
}

variable "vpc_security_groups" {
  type    = list(string)
  default = []
}

variable "vpc_cidr_block" {
  type    = list(string)
  default = []
}