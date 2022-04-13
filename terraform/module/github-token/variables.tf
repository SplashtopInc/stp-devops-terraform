### System ###
# AWS privilege
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

variable "secret_name" {
  type = string
  #tfsec:ignore:GEN001
  default = ""
}
