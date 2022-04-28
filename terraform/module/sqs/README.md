<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.11.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
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
| <a name="input_aws_account_name"></a> [aws\_account\_name](#input\_aws\_account\_name) | n/a | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `"prod"` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | n/a | `string` | `"user"` | no |
| <a name="input_project"></a> [project](#input\_project) | n/a | `string` | `"be"` | no |
| <a name="input_region"></a> [region](#input\_region) | ## Site information ### | `string` | `"us-west-2"` | no |
| <a name="input_shoryuken_sqs_list_dead"></a> [shoryuken\_sqs\_list\_dead](#input\_shoryuken\_sqs\_list\_dead) | SQS queues list of dead for shoryuken | `list(string)` | <pre>[<br>  "be-async-dead-high",<br>  "be-async-dead-low",<br>  "be-async-dead-delay"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_SQS-Prefix"></a> [SQS-Prefix](#output\_SQS-Prefix) | ## Output ### |
| <a name="output_SRC-Command"></a> [SRC-Command](#output\_SRC-Command) | n/a |
| <a name="output_Webhook-SQS"></a> [Webhook-SQS](#output\_Webhook-SQS) | n/a |
<!-- END_TF_DOCS -->