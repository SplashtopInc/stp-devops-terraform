<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.73 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc-be"></a> [vpc-be](#module\_vpc-be) | terraform-aws-modules/vpc/aws | 3.6.0 |

## Resources

| Name | Type |
|------|------|
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_eip.be_alloc_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eip) | data source |
| [aws_subnets.stp-vpc-backend-private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_name"></a> [account\_name](#input\_account\_name) | the aws account | `string` | `""` | no |
| <a name="input_assume_role"></a> [assume\_role](#input\_assume\_role) | the aws role to be assigned to | `string` | `""` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | ## Site information ### | `string` | `"splashtop.de"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | the environment ex: prod, qa, test | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | vpc name | `string` | `"stp-vpc-backend"` | no |
| <a name="input_project"></a> [project](#input\_project) | the project name | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | the aws region | `string` | `""` | no |
| <a name="input_short_region"></a> [short\_region](#input\_short\_region) | the short name of the aws region | `string` | `""` | no |
| <a name="input_vpc_backend_az_end"></a> [vpc\_backend\_az\_end](#input\_vpc\_backend\_az\_end) | n/a | `number` | `3` | no |
| <a name="input_vpc_backend_az_start"></a> [vpc\_backend\_az\_start](#input\_vpc\_backend\_az\_start) | n/a | `number` | `0` | no |
| <a name="input_vpc_backend_cidr"></a> [vpc\_backend\_cidr](#input\_vpc\_backend\_cidr) | n/a | `string` | `"10.21.0.0/16"` | no |
| <a name="input_vpc_backend_nat_eip_ids"></a> [vpc\_backend\_nat\_eip\_ids](#input\_vpc\_backend\_nat\_eip\_ids) | n/a | `list(string)` | `[]` | no |
| <a name="input_vpc_backend_pri_subnets"></a> [vpc\_backend\_pri\_subnets](#input\_vpc\_backend\_pri\_subnets) | n/a | `list(string)` | <pre>[<br>  "10.21.18.0/23",<br>  "10.21.20.0/23"<br>]</pre> | no |
| <a name="input_vpc_backend_pub_subnets"></a> [vpc\_backend\_pub\_subnets](#input\_vpc\_backend\_pub\_subnets) | n/a | `list(string)` | <pre>[<br>  "10.21.2.0/23",<br>  "10.21.10.0/23"<br>]</pre> | no |
| <a name="input_vpc_backend_reuse_nat_ips"></a> [vpc\_backend\_reuse\_nat\_ips](#input\_vpc\_backend\_reuse\_nat\_ips) | n/a | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_VPC-BE"></a> [VPC-BE](#output\_VPC-BE) | ######## Output ######## |
| <a name="output_stp-vpc-backend-private-subnet-ids"></a> [stp-vpc-backend-private-subnet-ids](#output\_stp-vpc-backend-private-subnet-ids) | n/a |
| <a name="output_vpc-be-id"></a> [vpc-be-id](#output\_vpc-be-id) | ######## Output ######## |
<!-- END_TF_DOCS -->