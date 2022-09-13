### Output ###
output "OpenSearch_Log_Group_Name" {
  value = {
    "01_Search_Slow_Logs" = aws_cloudwatch_log_group.elasticsearch_log_group_search_logs.name
    "02_Index_Slow_Logs"  = aws_cloudwatch_log_group.elasticsearch_log_group_index_logs.name
    "03_Error_Logs"       = aws_cloudwatch_log_group.elasticsearch_log_group_application_logs.name
    "04_Audit_Logs"       = aws_cloudwatch_log_group.elasticsearch_log_group_audit_logs.name
  }
}

### Output ###
output "Premium_Inventory_Lambda_Execution_Role_ARN" {
  value = aws_iam_role.premium_inventory_lambda_execution_role.arn
}

### Output ###
output "OpenSearch_Infra" {
  value = {
    "01_Domain"        = "https://${aws_elasticsearch_domain.be_elasticsearch_domain.endpoint}:443"
    "02_SecurityGroup" = aws_elasticsearch_domain.be_elasticsearch_domain.vpc_options[*].security_group_ids
  }
}

output "OpenSearch_Master_User_Info" {
  sensitive = true
  value = {
    "03_Name"     = var.be_elasticsearch_master_user_name
    "04_Password" = var.be_elasticsearch_is_production ? random_password.be_elasticsearch_master_user_password[0].result : var.be_elasticsearch_nonprod_master_user_password
  }
}

### Output ###
output "Severless_Framework_Deployment_Request_Resources" {
  value = {
    "01_Lambda_Premium_Inventory_SG_ID"   = aws_security_group.lambda_premium_inventory_sg.id
    "02_Private_Subnet_IDs_of_VPC_Public" = data.aws_subnets.stp-vpc-pub-private.ids
  }
}


output "opensearch_endpoint" {
  value = "https://${aws_elasticsearch_domain.be_elasticsearch_domain.endpoint}:443"
}

output "nonprod_password" {
  sensitive = true
  value     = var.be_elasticsearch_nonprod_master_user_password
}
