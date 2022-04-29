<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.71.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 3.14.0 |

## Resources

| Name | Type |
|------|------|
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_security_groups.stp-vpc-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_groups) | data source |
| [aws_subnet_ids.stp-vpc-private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assume_role"></a> [assume\_role](#input\_assume\_role) | n/a | `string` | `""` | no |
| <a name="input_create_database_subnet_group"></a> [create\_database\_subnet\_group](#input\_create\_database\_subnet\_group) | n/a | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | ################### | `string` | `"stp-vpc-project"` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | AWS privilege | `string` | `""` | no |
| <a name="input_project"></a> [project](#input\_project) | n/a | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `""` | no |
| <a name="input_sg_whitelist_ips"></a> [sg\_whitelist\_ips](#input\_sg\_whitelist\_ips) | ## SG whitelist ### | `list(string)` | `[]` | no |
| <a name="input_vpc_az_end"></a> [vpc\_az\_end](#input\_vpc\_az\_end) | n/a | `number` | `3` | no |
| <a name="input_vpc_az_start"></a> [vpc\_az\_start](#input\_vpc\_az\_start) | n/a | `number` | `0` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | n/a | `string` | `"10.117.0.0/16"` | no |
| <a name="input_vpc_database_subnets"></a> [vpc\_database\_subnets](#input\_vpc\_database\_subnets) | n/a | `list(string)` | <pre>[<br>  "10.117.100.0/24"<br>]</pre> | no |
| <a name="input_vpc_nat_eip_ids"></a> [vpc\_nat\_eip\_ids](#input\_vpc\_nat\_eip\_ids) | n/a | `list(string)` | `[]` | no |
| <a name="input_vpc_pri_subnets"></a> [vpc\_pri\_subnets](#input\_vpc\_pri\_subnets) | n/a | `list(string)` | <pre>[<br>  "10.117.0.0/24"<br>]</pre> | no |
| <a name="input_vpc_pub_subnets"></a> [vpc\_pub\_subnets](#input\_vpc\_pub\_subnets) | n/a | `list(string)` | <pre>[<br>  "10.117.1.0/24"<br>]</pre> | no |
| <a name="input_vpc_reuse_nat_ips"></a> [vpc\_reuse\_nat\_ips](#input\_vpc\_reuse\_nat\_ips) | n/a | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_stp-vpc-default-sg"></a> [stp-vpc-default-sg](#output\_stp-vpc-default-sg) | n/a |
| <a name="output_stp-vpc-private-subnet-ids"></a> [stp-vpc-private-subnet-ids](#output\_stp-vpc-private-subnet-ids) | n/a |
| <a name="output_vpc-cidr-block"></a> [vpc-cidr-block](#output\_vpc-cidr-block) | n/a |
| <a name="output_vpc-cidr-block-str"></a> [vpc-cidr-block-str](#output\_vpc-cidr-block-str) | n/a |
| <a name="output_vpc-database-subnet"></a> [vpc-database-subnet](#output\_vpc-database-subnet) | n/a |
| <a name="output_vpc-id"></a> [vpc-id](#output\_vpc-id) | ######## Output ######## |
| <a name="output_vpc-info"></a> [vpc-info](#output\_vpc-info) | ######## Output ######## |
<!-- END_TF_DOCS -->