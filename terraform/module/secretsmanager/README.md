<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account"></a> [account](#input\_account) | aws account name | `string` | `""` | no |
| <a name="input_description"></a> [description](#input\_description) | secretsmanager\_description | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | environment for the resource | `string` | `""` | no |
| <a name="input_project"></a> [project](#input\_project) | project name of the resource | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | region for the resource | `string` | `""` | no |
| <a name="input_secret_name"></a> [secret\_name](#input\_secret\_name) | secretsmanager\_name | `string` | `""` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->