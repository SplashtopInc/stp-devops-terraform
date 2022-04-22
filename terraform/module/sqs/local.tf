locals {
  sqs_prefix = "${var.aws_account_name}-"
}

data "aws_caller_identity" "current" {}