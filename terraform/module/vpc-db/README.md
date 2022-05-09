<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.67.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.1.2 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.10.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | 2.1.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.1.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.1.0 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | 3.4.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.67.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc-db"></a> [vpc-db](#module\_vpc-db) | terraform-aws-modules/vpc/aws | 3.6.0 |

## Resources

| Name | Type |
|------|------|
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_subnet_ids.stp-vpc-db-all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) | data source |
| [aws_subnet_ids.stp-vpc-db-private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assume_role"></a> [assume\_role](#input\_assume\_role) | n/a | `string` | `""` | no |
| <a name="input_aws_account_name"></a> [aws\_account\_name](#input\_aws\_account\_name) | AWS account name for SQS naming prefix (for temporary) | `string` | `""` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | ## Site information ### | `string` | `"splashtop.de"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | ## VPCs ### DB | `string` | `"stp-vpc-db"` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | n/a | `string` | `""` | no |
| <a name="input_project"></a> [project](#input\_project) | n/a | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"us-west-2"` | no |
| <a name="input_vpc_db_az_end"></a> [vpc\_db\_az\_end](#input\_vpc\_db\_az\_end) | n/a | `number` | `3` | no |
| <a name="input_vpc_db_az_start"></a> [vpc\_db\_az\_start](#input\_vpc\_db\_az\_start) | n/a | `number` | `0` | no |
| <a name="input_vpc_db_cidr"></a> [vpc\_db\_cidr](#input\_vpc\_db\_cidr) | n/a | `string` | `"10.20.0.0/16"` | no |
| <a name="input_vpc_db_pri_subnets"></a> [vpc\_db\_pri\_subnets](#input\_vpc\_db\_pri\_subnets) | n/a | `list(string)` | <pre>[<br>  "10.20.18.0/24",<br>  "10.20.10.0/24"<br>]</pre> | no |
| <a name="input_vpc_db_pub_subnets"></a> [vpc\_db\_pub\_subnets](#input\_vpc\_db\_pub\_subnets) | n/a | `list(string)` | <pre>[<br>  "10.20.2.0/24",<br>  "10.20.20.0/24"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_stp-vpc-db-all-subnet-ids"></a> [stp-vpc-db-all-subnet-ids](#output\_stp-vpc-db-all-subnet-ids) | n/a |
| <a name="output_stp-vpc-db-private-subnet-ids"></a> [stp-vpc-db-private-subnet-ids](#output\_stp-vpc-db-private-subnet-ids) | n/a |
| <a name="output_vpc-db-id"></a> [vpc-db-id](#output\_vpc-db-id) | ######## Output ######## |
| <a name="output_vpc_db"></a> [vpc\_db](#output\_vpc\_db) | ######## Output ######## |
<!-- END_TF_DOCS -->