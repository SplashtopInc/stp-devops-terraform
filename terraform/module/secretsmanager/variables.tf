################################################################
### Site information ###
variable "region" {
  description = "region for the resource"
  type        = string
  default     = ""
}
variable "environment" {
  description = "environment for the resource"
  type        = string
  default     = ""
}
variable "project" {
  description = "project name of the resource"
  type        = string
  default     = ""
}
variable "account" {
  description = "aws account name"
  type        = string
  default     = ""
}

################################################################################
# Secret Manager Module
################################################################################

variable "secret_name" {
  description = "secretsmanager_name"
  type        = string
  default     = ""
}

variable "secret_description" {
  description = "secretsmanager_description"
  type        = string
  default     = ""
}

# The map here can come from other supported configurations
# like locals, resource attribute, map() built-in, etc.
variable "secret_value" {
  default = {
    key1 = "value1"
  }

  type = map(string)
}