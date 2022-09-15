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

variable "description" {
  description = "secretsmanager_description"
  type        = string
  default     = ""
}