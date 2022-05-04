<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_chart"></a> [chart](#input\_chart) | (Required) Chart name to be installed. The chart name can be local path, a URL to a chart, or the name of the chart if repository is specified | `string` | `""` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | Specify the exact chart version to install. If this is not specified, the latest version is installed. | `string` | `""` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | (Optional) Create the namespace if it does not yet exist. Defaults to false. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) Release name | `string` | `""` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | (Optional) The namespace to install the release into. Defaults to default | `string` | `"default"` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | (Optional) Repository URL where to locate the requested chart. | `string` | `""` | no |
| <a name="input_skip_crds"></a> [skip\_crds](#input\_skip\_crds) | (Optional) If set, no CRDs will be installed. By default, CRDs are installed if not already present. | `bool` | `false` | no |
| <a name="input_values"></a> [values](#input\_values) | (Optional) List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options | `list(string)` | `null` | no |
| <a name="input_verify"></a> [verify](#input\_verify) | (Optional) Verify the package before installing it. Helm uses a provenance file to verify the integrity of the chart | `bool` | `false` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->