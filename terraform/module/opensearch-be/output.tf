### Output ###
output "OpenSearch_Infra" {
  value = {
    "01_Domain"        = "https://${aws_elasticsearch_domain.be_elasticsearch_domain.endpoint}"
    "02_SecurityGroup" = aws_elasticsearch_domain.be_elasticsearch_domain.vpc_options[*].security_group_ids
  }
}

output "OpenSearch_Log_Group_Name" {
  value = {
    "01_Search_Slow_Logs" = aws_cloudwatch_log_group.elasticsearch_log_group_search_logs.name
    "02_Index_Slow_Logs"  = aws_cloudwatch_log_group.elasticsearch_log_group_index_logs.name
    "03_Error_Logs"       = aws_cloudwatch_log_group.elasticsearch_log_group_application_logs.name
    "04_Audit_Logs"       = aws_cloudwatch_log_group.elasticsearch_log_group_audit_logs.name
  }
}

output "Premium_Inventory_Lambda_Execution_Role_ARN" {
  value = aws_iam_role.premium_inventory_lambda_execution_role.arn
}

output "OpenSearch_Master_User_ARN" {
  value = aws_iam_role.premium_inventory_opensearch_master_user.arn
}