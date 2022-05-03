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
| [aws_dlm_lifecycle_policy.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dlm_lifecycle_policy) | resource |
| [aws_iam_role.dlm_lifecycle_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.dlm_lifecycle](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_interval"></a> [interval](#input\_interval) | How often this lifecycle policy should be evaluated. 1,2,3,4,6,8,12 or 24 are valid values. | `number` | `24` | no |
| <a name="input_interval_unit"></a> [interval\_unit](#input\_interval\_unit) | The unit for how often the lifecycle policy should be evaluated. HOURS is currently the only allowed value and also the default value | `string` | `"HOURS"` | no |
| <a name="input_keep_days"></a> [keep\_days](#input\_keep\_days) | (Optional) A list of times in 24 hour clock format that sets when the lifecycle policy should be evaluated. Max of 1 | `number` | `7` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"1 weeks of daily snapshots"` | no |
| <a name="input_state"></a> [state](#input\_state) | Whether the lifecycle policy should be enabled or disabled. ENABLED or DISABLED are valid values | `string` | `"ENABLED"` | no |
| <a name="input_target_tags"></a> [target\_tags](#input\_target\_tags) | (Optional) A map of tag keys and their values. Any resources that match the resource\_types and are tagged with any of these tags will be targeted | `map(any)` | <pre>{<br>  "DLM-snapshot": true<br>}</pre> | no |
| <a name="input_times"></a> [times](#input\_times) | A list of times in 24 hour clock format that sets when the lifecycle policy should be evaluated | `list(any)` | <pre>[<br>  "23:45"<br>]</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->