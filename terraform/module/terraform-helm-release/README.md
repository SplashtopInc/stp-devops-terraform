<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_helm_release"></a> [helm\_release](#module\_helm\_release) | terraform-module/release/helm | 2.8.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app"></a> [app](#input\_app) | an application to deploy | `map(any)` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | namespace where to deploy an application | `string` | n/a | yes |
| <a name="input_repository"></a> [repository](#input\_repository) | Helm repository | `string` | n/a | yes |
| <a name="input_repository_config"></a> [repository\_config](#input\_repository\_config) | repository configuration | `map(any)` | `{}` | no |
| <a name="input_set"></a> [set](#input\_set) | Value block with custom STRING values to be merged with the values yaml. | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `null` | no |
| <a name="input_set_sensitive"></a> [set\_sensitive](#input\_set\_sensitive) | Value block with custom sensitive values to be merged with the values yaml that won't be exposed in the plan's diff. | <pre>list(object({<br>    path  = string<br>    value = string<br>  }))</pre> | `null` | no |
| <a name="input_values"></a> [values](#input\_values) | Extra values | `list(string)` | `[]` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->