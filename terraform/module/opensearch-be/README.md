<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.11.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.elasticsearch_log_group_application_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.elasticsearch_log_group_audit_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.elasticsearch_log_group_index_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.elasticsearch_log_group_search_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_resource_policy.elasticsearch_log_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_resource_policy) | resource |
| [aws_elasticsearch_domain.be_elasticsearch_domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticsearch_domain) | resource |
| [aws_elasticsearch_domain_policy.be_elasticsearch_domain_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticsearch_domain_policy) | resource |
| [aws_iam_policy.premium_inventory_lambda_execution_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.premium_inventory_lambda_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.premium_inventory_opensearch_master_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.attach_lambda_execution_to_premium_inventory_lambda_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.attach_opensearch_fullaccess_policy_to_premium_inventory_opensearch_master_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.attach_s3_policy_to_premium_inventory_lambda_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_service_linked_role.elasticsearch_service_linked_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_service_linked_role) | resource |
| [aws_security_group.elasticsearch_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_subnet_ids.stp_vpc_db_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) | data source |
| [aws_vpc.stp_vpc_db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account"></a> [account](#input\_account) | n/a | `string` | `""` | no |
| <a name="input_assume_role"></a> [assume\_role](#input\_assume\_role) | n/a | `string` | `""` | no |
| <a name="input_aws_account_name"></a> [aws\_account\_name](#input\_aws\_account\_name) | AWS account name for SQS naming prefix (for temporary) | `string` | `""` | no |
| <a name="input_be_elasticsearch_application_logs_enabled"></a> [be\_elasticsearch\_application\_logs\_enabled](#input\_be\_elasticsearch\_application\_logs\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_be_elasticsearch_audit_logs_enabled"></a> [be\_elasticsearch\_audit\_logs\_enabled](#input\_be\_elasticsearch\_audit\_logs\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_be_elasticsearch_az_count"></a> [be\_elasticsearch\_az\_count](#input\_be\_elasticsearch\_az\_count) | AZ count of ElasticSearch cluster, only allow 2 or 3 | `number` | `2` | no |
| <a name="input_be_elasticsearch_create_role"></a> [be\_elasticsearch\_create\_role](#input\_be\_elasticsearch\_create\_role) | Create Service Linked Role for ElasticSearch | `bool` | `true` | no |
| <a name="input_be_elasticsearch_dedicated_master_count"></a> [be\_elasticsearch\_dedicated\_master\_count](#input\_be\_elasticsearch\_dedicated\_master\_count) | Dedicated Master count | `number` | `3` | no |
| <a name="input_be_elasticsearch_dedicated_master_enalbed"></a> [be\_elasticsearch\_dedicated\_master\_enalbed](#input\_be\_elasticsearch\_dedicated\_master\_enalbed) | Enabled Dedicated Master | `bool` | `true` | no |
| <a name="input_be_elasticsearch_dedicated_master_type"></a> [be\_elasticsearch\_dedicated\_master\_type](#input\_be\_elasticsearch\_dedicated\_master\_type) | Dedicated Master instance type | `string` | `"m6g.large.search"` | no |
| <a name="input_be_elasticsearch_index_logs_enabled"></a> [be\_elasticsearch\_index\_logs\_enabled](#input\_be\_elasticsearch\_index\_logs\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_be_elasticsearch_instance_count"></a> [be\_elasticsearch\_instance\_count](#input\_be\_elasticsearch\_instance\_count) | Instance count of ElasticSearch cluster | `number` | `2` | no |
| <a name="input_be_elasticsearch_instance_type"></a> [be\_elasticsearch\_instance\_type](#input\_be\_elasticsearch\_instance\_type) | Instance type of ElasticSearch cluster | `string` | `"r6g.large.search"` | no |
| <a name="input_be_elasticsearch_log_retention"></a> [be\_elasticsearch\_log\_retention](#input\_be\_elasticsearch\_log\_retention) | Log retention of ElasticSearch cluster | `number` | `30` | no |
| <a name="input_be_elasticsearch_multiaz"></a> [be\_elasticsearch\_multiaz](#input\_be\_elasticsearch\_multiaz) | Multi-AZ of ElasticSearch cluster | `bool` | `true` | no |
| <a name="input_be_elasticsearch_search_logs_enabled"></a> [be\_elasticsearch\_search\_logs\_enabled](#input\_be\_elasticsearch\_search\_logs\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_be_elasticsearch_volume_size"></a> [be\_elasticsearch\_volume\_size](#input\_be\_elasticsearch\_volume\_size) | Volume size of ElasticSearch cluster in GB | `number` | `10` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `""` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | ## System ### AWS privilege | `string` | `""` | no |
| <a name="input_project"></a> [project](#input\_project) | n/a | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_OpenSearch_Infra"></a> [OpenSearch\_Infra](#output\_OpenSearch\_Infra) | ## Output ### |
| <a name="output_OpenSearch_Log_Group_Name"></a> [OpenSearch\_Log\_Group\_Name](#output\_OpenSearch\_Log\_Group\_Name) | n/a |
| <a name="output_OpenSearch_Master_User_ARN"></a> [OpenSearch\_Master\_User\_ARN](#output\_OpenSearch\_Master\_User\_ARN) | n/a |
| <a name="output_Premium_Inventory_Lambda_Execution_Role_ARN"></a> [Premium\_Inventory\_Lambda\_Execution\_Role\_ARN](#output\_Premium\_Inventory\_Lambda\_Execution\_Role\_ARN) | n/a |
<!-- END_TF_DOCS -->