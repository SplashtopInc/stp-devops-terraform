#tfsec:ignore:aws-sqs-enable-queue-encryption
resource "aws_sqs_queue" "shoryuken_sqs_dead" {
  #ts:skip=AWS.SQS.NetworkSecurity.High.0570 skip
  # checkov:skip=CKV_AWS_27: DEAD QUEUE UNENCRYPTED IS KNOWN ISSUE
  count                      = length(var.shoryuken_sqs_list_dead)
  name                       = "${local.sqs_prefix}${var.shoryuken_sqs_list_dead[count.index]}"
  visibility_timeout_seconds = 0
  message_retention_seconds  = 1209600
  max_message_size           = 262144
  delay_seconds              = 0
  receive_wait_time_seconds  = 0
  sqs_managed_sse_enabled    = var.sqs_managed_sse_enabled

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "OnlyAllowSelfAWSAccountAccess",
      "Action": "sqs:*",
      "Effect": "Allow",
      "Resource": "arn:aws:sqs:${var.region}:${data.aws_caller_identity.current.account_id}:${local.sqs_prefix}${var.shoryuken_sqs_list_dead[count.index]}",
      "Principal": {
        "AWS": [
          "${data.aws_caller_identity.current.account_id}"
        ]
      }
    }
  ]
}
POLICY

  tags = {
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_sqs_queue" "shoryuken_sqs_high_60" {
  name                              = "${local.sqs_prefix}be-async-high-60"
  visibility_timeout_seconds        = 60
  message_retention_seconds         = 604800
  max_message_size                  = 262144
  delay_seconds                     = 0
  receive_wait_time_seconds         = 0
  kms_master_key_id                 = "alias/aws/sqs" #tfsec:ignore:aws-sqs-queue-encryption-use-cmk
  kms_data_key_reuse_period_seconds = 300

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.shoryuken_sqs_dead[0].arn
    maxReceiveCount     = 256
  })

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "OnlyAllowSelfAWSAccountAccess",
      "Action": "sqs:*",
      "Effect": "Allow",
      "Resource": "arn:aws:sqs:${var.region}:${data.aws_caller_identity.current.account_id}:${local.sqs_prefix}be-async-high-60",
      "Principal": {
        "AWS": [
          "${data.aws_caller_identity.current.account_id}"
        ]
      }
    }
  ]
}
POLICY

  tags = {
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_sqs_queue" "shoryuken_sqs_low_60" {
  name                       = "${local.sqs_prefix}be-async-low-60"
  visibility_timeout_seconds = 60
  message_retention_seconds  = 604800
  max_message_size           = 262144
  delay_seconds              = 0
  receive_wait_time_seconds  = 0
  #tfsec:ignore:aws-sqs-queue-encryption-use-cmk
  kms_master_key_id                 = "alias/aws/sqs"
  kms_data_key_reuse_period_seconds = 300

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.shoryuken_sqs_dead[1].arn
    maxReceiveCount     = 256
  })

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "OnlyAllowSelfAWSAccountAccess",
      "Action": "sqs:*",
      "Effect": "Allow",
      "Resource": "arn:aws:sqs:${var.region}:${data.aws_caller_identity.current.account_id}:${local.sqs_prefix}be-async-low-60",
      "Principal": {
        "AWS": [
          "${data.aws_caller_identity.current.account_id}"
        ]
      }
    }
  ]
}
POLICY

  tags = {
    Project     = var.project
    Environment = var.environment
  }
}


resource "aws_sqs_queue" "shoryuken_sqs_low_300" {
  name                       = "${local.sqs_prefix}be-async-low-300"
  visibility_timeout_seconds = 300
  message_retention_seconds  = 604800
  max_message_size           = 262144
  delay_seconds              = 0
  receive_wait_time_seconds  = 0
  #tfsec:ignore:aws-sqs-queue-encryption-use-cmk
  kms_master_key_id                 = "alias/aws/sqs"
  kms_data_key_reuse_period_seconds = 300

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.shoryuken_sqs_dead[1].arn
    maxReceiveCount     = 256
  })

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "OnlyAllowSelfAWSAccountAccess",
      "Action": "sqs:*",
      "Effect": "Allow",
      "Resource": "arn:aws:sqs:${var.region}:${data.aws_caller_identity.current.account_id}:${local.sqs_prefix}be-async-low-300",
      "Principal": {
        "AWS": [
          "${data.aws_caller_identity.current.account_id}"
        ]
      }
    }
  ]
}
POLICY

  tags = {
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_sqs_queue" "shoryuken_sqs_delay_600" {
  name                              = "${local.sqs_prefix}be-async-delay-600"
  visibility_timeout_seconds        = 600
  message_retention_seconds         = 604800
  max_message_size                  = 262144
  delay_seconds                     = 600
  receive_wait_time_seconds         = 0
  kms_master_key_id                 = "alias/aws/sqs" #tfsec:ignore:aws-sqs-queue-encryption-use-cmk
  kms_data_key_reuse_period_seconds = 300

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.shoryuken_sqs_dead[2].arn
    maxReceiveCount     = 64
  })

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "OnlyAllowSelfAWSAccountAccess",
      "Action": "sqs:*",
      "Effect": "Allow",
      "Resource": "arn:aws:sqs:${var.region}:${data.aws_caller_identity.current.account_id}:${local.sqs_prefix}be-async-delay-600",
      "Principal": {
        "AWS": [
          "${data.aws_caller_identity.current.account_id}"
        ]
      }
    }
  ]
}
POLICY

  tags = {
    Project     = var.project
    Environment = var.environment
  }
}

#tfsec:ignore:aws-sqs-enable-queue-encryption
resource "aws_sqs_queue" "src_command_queue_dead" {
  #ts:skip=AWS.SQS.NetworkSecurity.High.0570 skip
  # checkov:skip=CKV_AWS_27: DEAD QUEUE UNENCRYPTED IS KNOWN ISSUE
  name                       = "src-command-queue-dead"
  visibility_timeout_seconds = 0
  message_retention_seconds  = 86400
  max_message_size           = 262144
  delay_seconds              = 0
  receive_wait_time_seconds  = 0
  sqs_managed_sse_enabled    = var.sqs_managed_sse_enabled

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "OnlyAllowSelfAWSAccountAccess",
      "Action": "sqs:*",
      "Effect": "Allow",
      "Resource": "arn:aws:sqs:${var.region}:${data.aws_caller_identity.current.account_id}:src-command-queue-dead",
      "Principal": {
        "AWS": [
          "${data.aws_caller_identity.current.account_id}"
        ]
      }
    }
  ]
}
POLICY

  tags = {
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_sqs_queue" "src_command_queue" {
  name                              = "src-command-queue"
  visibility_timeout_seconds        = 60
  message_retention_seconds         = 21600
  max_message_size                  = 262144
  delay_seconds                     = 0
  receive_wait_time_seconds         = 0
  kms_master_key_id                 = "alias/aws/sqs" #tfsec:ignore:aws-sqs-queue-encryption-use-cmk
  kms_data_key_reuse_period_seconds = 300

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.src_command_queue_dead.arn
    maxReceiveCount     = 2
  })

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "OnlyAllowSelfAWSAccountAccess",
      "Action": "sqs:*",
      "Effect": "Allow",
      "Resource": "arn:aws:sqs:${var.region}:${data.aws_caller_identity.current.account_id}:src-command-queue",
      "Principal": {
        "AWS": [
          "${data.aws_caller_identity.current.account_id}"
        ]
      }
    }
  ]
}
POLICY

  tags = {
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_sqs_queue" "webhook_sqs" {
  name                              = "webhook-sqs"
  visibility_timeout_seconds        = 60
  message_retention_seconds         = 1800
  max_message_size                  = 262144
  delay_seconds                     = 0
  receive_wait_time_seconds         = 0
  kms_master_key_id                 = "alias/aws/sqs" #tfsec:ignore:aws-sqs-queue-encryption-use-cmk
  kms_data_key_reuse_period_seconds = 300

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "OnlyAllowSelfAWSAccountAccess",
      "Action": "sqs:*",
      "Effect": "Allow",
      "Resource": "arn:aws:sqs:${var.region}:${data.aws_caller_identity.current.account_id}:webhook-sqs",
      "Principal": {
        "AWS": [
          "${data.aws_caller_identity.current.account_id}"
        ]
      }
    }
  ]
}
POLICY

  tags = {
    Project     = var.project
    Environment = var.environment
  }
}
