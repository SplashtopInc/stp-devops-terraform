### Output ###
output "OpenSearch_Log_Group_Name" {
  value = {
    "01_Search_Slow_Logs" = var.enabled ? aws_cloudwatch_log_group.elasticsearch_log_group_search_logs[0].name : ""
    "02_Index_Slow_Logs"  = var.enabled ? aws_cloudwatch_log_group.elasticsearch_log_group_index_logs[0].name : ""
    "03_Error_Logs"       = var.enabled ? aws_cloudwatch_log_group.elasticsearch_log_group_application_logs[0].name : ""
    "04_Audit_Logs"       = var.enabled ? aws_cloudwatch_log_group.elasticsearch_log_group_audit_logs[0].name : ""
  }
}

### Output ###
output "Premium_Inventory_Lambda_Execution_Role_ARN" {
  value = var.enabled ? aws_iam_role.premium_inventory_lambda_execution_role[0].arn : ""
}

### Output ###
output "OpenSearch_Infra" {
  value = {
    "01_Domain"        = var.enabled ? "https://${aws_elasticsearch_domain.be_elasticsearch_domain[0].endpoint}:443" : ""
    "02_SecurityGroup" = var.enabled ? "${aws_elasticsearch_domain.be_elasticsearch_domain[0].vpc_options[*].security_group_ids}" : ""
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
    "01_Lambda_Premium_Inventory_SG_ID"   = var.enabled ? aws_security_group.lambda_premium_inventory_sg[0].id : ""
    "02_Private_Subnet_IDs_of_VPC_Public" = var.enabled ? data.aws_subnets.stp-vpc-pub-private.ids : []
  }
}


output "opensearch_endpoint" {
  value = var.enabled ? "https://${aws_elasticsearch_domain.be_elasticsearch_domain[0].endpoint}:443" : 0
}

output "nonprod_password" {
  sensitive = true
  value     = var.be_elasticsearch_nonprod_master_user_password
}
