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
  description = "(Required) Specifies the secret containing the version that you want to retrieve. You can specify either the Amazon Resource Name (ARN) or the friendly name of the secret."
  type        = string
  #tfsec:ignore:GEN001
  default = ""
}

variable "version_id" {
  description = "(Optional) Specifies the unique identifier of the version of the secret that you want to retrieve. Overrides version_stage"
  type        = string
  default     = ""
}

variable "version_stage" {
  description = "(Optional) Specifies the secret version that you want to retrieve by the staging label attached to the version. Defaults to AWSCURRENT."
  type        = string
  default     = ""
}