<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc-peering-be2db"></a> [vpc-peering-be2db](#module\_vpc-peering-be2db) | cloudposse/vpc-peering/aws | 0.9.0 |
| <a name="module_vpc-peering-pub2be"></a> [vpc-peering-pub2be](#module\_vpc-peering-pub2be) | cloudposse/vpc-peering/aws | 0.9.0 |
| <a name="module_vpc-peering-pub2db"></a> [vpc-peering-pub2db](#module\_vpc-peering-pub2db) | cloudposse/vpc-peering/aws | 0.9.0 |

## Resources

| Name | Type |
|------|------|
| [aws_route_tables.vpc_be](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route_tables) | data source |
| [aws_route_tables.vpc_db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route_tables) | data source |
| [aws_route_tables.vpc_pub](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route_tables) | data source |
| [aws_vpc.vpc_be](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [aws_vpc.vpc_db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [aws_vpc.vpc_pub](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assume_role"></a> [assume\_role](#input\_assume\_role) | n/a | `string` | `""` | no |
| <a name="input_aws_account_name"></a> [aws\_account\_name](#input\_aws\_account\_name) | AWS account name for SQS naming prefix (for temporary) | `string` | `"aws-rd"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `""` | no |
| <a name="input_module"></a> [module](#input\_module) | n/a | `string` | `"eks"` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | AWS privilege | `string` | `"default"` | no |
| <a name="input_project"></a> [project](#input\_project) | n/a | `string` | `"BE"` | no |
| <a name="input_state_bucket"></a> [state\_bucket](#input\_state\_bucket) | ## System ### Terraform state bucket | `string` | `""` | no |
| <a name="input_vpc_be_id"></a> [vpc\_be\_id](#input\_vpc\_be\_id) | vpc be module outputs the ID under the name vpc\_be\_id | `string` | `""` | no |
| <a name="input_vpc_db_id"></a> [vpc\_db\_id](#input\_vpc\_db\_id) | vpc pub module outputs the ID under the name vpc\_db\_id | `string` | `""` | no |
| <a name="input_vpc_pub_id"></a> [vpc\_pub\_id](#input\_vpc\_pub\_id) | vpc pub module outputs the ID under the name vpc\_pub\_id | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpc-peer"></a> [vpc-peer](#output\_vpc-peer) | ######## Output ######## |
<!-- END_TF_DOCS -->