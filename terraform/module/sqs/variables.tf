### Site information ###
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

variable "aws_account_name" {
  type    = string
  default = "the aws account name"
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