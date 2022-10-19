### Output ###
output "SQS-Prefix" {
  value = local.sqs_prefix
}
output "SRC-Command" {
  value = aws_sqs_queue.src_command_queue.id
}
output "Webhook-SQS" {
  value = aws_sqs_queue.webhook_sqs.id
}
