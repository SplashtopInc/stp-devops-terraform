### System ###
# Terraform state bucket
variable "state_bucket" {
  type    = string
  default = ""
}
# AWS privilege
variable "profile" {
  type    = string
  default = ""
}
variable "assume_role" {
  type    = string
  default = ""
}
# AWS account name for SQS naming prefix (for temporary)
variable "aws_account_name" {
  type    = string
  default = ""
}

variable "project" {
  type    = string
  default = ""
}

variable "module" {
  type    = string
  default = "eks"
}

variable "environment" {
  type    = string
  default = ""
}

## Passing outputs between modules
variable "vpc_be_id" {
  description = "vpc be module outputs the ID under the name vpc_be_id"
  type        = string
  default     = ""
}

variable "vpc_pub_id" {
  description = "vpc pub module outputs the ID under the name vpc_pub_id"
  type        = string
  default     = ""
}

variable "vpc_db_id" {
  description = "vpc pub module outputs the ID under the name vpc_db_id"
  type        = string
  default     = ""
}