#tfsec:ignore:aws-cloudwatch-log-group-customer-key
resource "aws_cloudwatch_log_group" "elasticsearch_log_group_search_logs" {
  #checkov:skip=CKV_AWS_158:not use kms
  count             = var.enabled ? 1 : 0
  name              = "/aws/OpenSearchService/domains/${local.elasticsearch_cluster_domain}/search-logs"
  retention_in_days = var.be_elasticsearch_log_retention
}
#tfsec:ignore:aws-cloudwatch-log-group-customer-key
resource "aws_cloudwatch_log_group" "elasticsearch_log_group_index_logs" {
  #checkov:skip=CKV_AWS_158:not use kms
  count             = var.enabled ? 1 : 0
  name              = "/aws/OpenSearchService/domains/${local.elasticsearch_cluster_domain}/index-logs"
  retention_in_days = var.be_elasticsearch_log_retention
}
#tfsec:ignore:aws-cloudwatch-log-group-customer-key
resource "aws_cloudwatch_log_group" "elasticsearch_log_group_application_logs" {
  #checkov:skip=CKV_AWS_158:not use kms
  count             = var.enabled ? 1 : 0
  name              = "/aws/OpenSearchService/domains/${local.elasticsearch_cluster_domain}/application-logs"
  retention_in_days = var.be_elasticsearch_log_retention
}
#tfsec:ignore:aws-cloudwatch-log-group-customer-key
resource "aws_cloudwatch_log_group" "elasticsearch_log_group_audit_logs" {
  #checkov:skip=CKV_AWS_158:not use kms
  count             = var.enabled ? 1 : 0
  name              = "/aws/OpenSearchService/domains/${local.elasticsearch_cluster_domain}/audit-logs"
  retention_in_days = var.be_elasticsearch_log_retention
}

resource "aws_cloudwatch_log_resource_policy" "elasticsearch_log_policy" {
  count       = var.enabled ? 1 : 0
  policy_name = "${local.elasticsearch_cluster_domain}-log-policy"

  policy_document = <<CONFIG
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "es.amazonaws.com"
      },
      "Action": [
        "logs:PutLogEvents",
        "logs:PutLogEventsBatch",
        "logs:CreateLogStream"
      ],
      "Resource": [
        "${aws_cloudwatch_log_group.elasticsearch_log_group_search_logs[0].arn}:*",
        "${aws_cloudwatch_log_group.elasticsearch_log_group_index_logs[0].arn}:*",
        "${aws_cloudwatch_log_group.elasticsearch_log_group_application_logs[0].arn}:*",
        "${aws_cloudwatch_log_group.elasticsearch_log_group_audit_logs[0].arn}:*"
      ]
    }
  ]
}
CONFIG
}


