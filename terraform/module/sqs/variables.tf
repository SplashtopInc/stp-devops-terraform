### Site information ###
variable "region" {
  type    = string
  default = ""
}
variable "environment" {
  type    = string
  default = "prod"
}
variable "project" {
  type    = string
  default = "be"
}

variable "owner" {
  type    = string
  default = "user"
}

variable "aws_account_name" {
  type    = string
  default = ""
}

variable "shoryuken_sqs_list_dead" {
  description = "SQS queues list of dead for shoryuken"
  type        = list(string)
  default = [
    "be-async-dead-high",
    "be-async-dead-low",
    "be-async-dead-delay"
  ]
}

variable "sqs_managed_sse_enabled" {
  description = "Boolean to enable server-side encryption (SSE) of message content with SQS-owned encryption keys"
  type        = bool
  default     = true
}

variable "enabled" {
  description = "Set to false to prevent the module from creating any resources"
  type        = bool
  default     = true
}