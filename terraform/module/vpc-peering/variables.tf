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

variable "enabled" {
  description = "Set to false to prevent the module from creating any resources"
  type        = bool
  default     = true
}

## 
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