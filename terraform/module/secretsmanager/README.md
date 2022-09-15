<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.30.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account"></a> [account](#input\_account) | aws account name | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | environment for the resource | `string` | `""` | no |
| <a name="input_project"></a> [project](#input\_project) | project name of the resource | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | region for the resource | `string` | `""` | no |
| <a name="input_secret_description"></a> [secret\_description](#input\_secret\_description) | secretsmanager\_description | `string` | `""` | no |
| <a name="input_secret_name"></a> [secret\_name](#input\_secret\_name) | secretsmanager\_name | `string` | `""` | no |
| <a name="input_secret_value"></a> [secret\_value](#input\_secret\_value) | The map here can come from other supported configurations like locals, resource attribute, map() built-in, etc. | `map(string)` | <pre>{<br>  "key1": "value1"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secretsmanager_secret_name"></a> [secretsmanager\_secret\_name](#output\_secretsmanager\_secret\_name) | secrets manager for stored secret |
<!-- END_TF_DOCS -->