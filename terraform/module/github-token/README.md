<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.10.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret_version.github-token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `""` | no |
| <a name="input_project"></a> [project](#input\_project) | n/a | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | ## System ### AWS privilege | `string` | `""` | no |
| <a name="input_secret_name"></a> [secret\_name](#input\_secret\_name) | (Required) Specifies the secret containing the version that you want to retrieve. You can specify either the Amazon Resource Name (ARN) or the friendly name of the secret. | `string` | `""` | no |
| <a name="input_version_id"></a> [version\_id](#input\_version\_id) | (Optional) Specifies the unique identifier of the version of the secret that you want to retrieve. Overrides version\_stage | `string` | `""` | no |
| <a name="input_version_stage"></a> [version\_stage](#input\_version\_stage) | (Optional) Specifies the secret version that you want to retrieve by the staging label attached to the version. Defaults to AWSCURRENT. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_github-user-token"></a> [github-user-token](#output\_github-user-token) | n/a |
<!-- END_TF_DOCS -->