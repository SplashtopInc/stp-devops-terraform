### Site information ###
variable "region" {
  type    = string
  default = "us-west-2"
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
