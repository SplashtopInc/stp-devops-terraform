<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.73 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.35.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_sqs_queue.shoryuken_sqs_dead](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue.shoryuken_sqs_delay_600](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue.shoryuken_sqs_high_60](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue.shoryuken_sqs_low_300](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue.shoryuken_sqs_low_60](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue.src_command_queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue.src_command_queue_dead](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue.webhook_sqs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assume_role"></a> [assume\_role](#input\_assume\_role) | the aws role to be assigned to | `string` | `""` | no |
| <a name="input_aws_account_name"></a> [aws\_account\_name](#input\_aws\_account\_name) | n/a | `string` | `"the aws account name"` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | the environment ex: prod, qa, test | `string` | `""` | no |
| <a name="input_project"></a> [project](#input\_project) | the project name | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | the aws region | `string` | `""` | no |
| <a name="input_shoryuken_sqs_list_dead"></a> [shoryuken\_sqs\_list\_dead](#input\_shoryuken\_sqs\_list\_dead) | SQS queues list of dead for shoryuken | `list(string)` | <pre>[<br>  "be-async-dead-high",<br>  "be-async-dead-low",<br>  "be-async-dead-delay"<br>]</pre> | no |
| <a name="input_sqs_managed_sse_enabled"></a> [sqs\_managed\_sse\_enabled](#input\_sqs\_managed\_sse\_enabled) | Boolean to enable server-side encryption (SSE) of message content with SQS-owned encryption keys | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_SQS-Prefix"></a> [SQS-Prefix](#output\_SQS-Prefix) | ## Output ### |
| <a name="output_SRC-Command"></a> [SRC-Command](#output\_SRC-Command) | n/a |
| <a name="output_Webhook-SQS"></a> [Webhook-SQS](#output\_Webhook-SQS) | n/a |
<!-- END_TF_DOCS -->