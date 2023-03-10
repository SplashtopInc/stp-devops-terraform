<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.73 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.73 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc-pub"></a> [vpc-pub](#module\_vpc-pub) | ../vpc-pub-v3.6.0 | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_security_group.stp-ip-whitelist-office-nonprod](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.stp-ip-whitelist-outside-nonprod](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.stp-office-ip-whitelist](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_eip.pub_alloc_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eip) | data source |
| [aws_subnets.stp-vpc-pub-private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_subnets.stp-vpc-pub-public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assume_role"></a> [assume\_role](#input\_assume\_role) | the aws role to be assigned to | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | the environment ex: prod, qa, test | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | ## VPCs ### | `string` | `"stp-vpc-pub"` | no |
| <a name="input_project"></a> [project](#input\_project) | the project name | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | the aws region | `string` | `""` | no |
| <a name="input_sg_whitelist_ips_office_nonprod_http"></a> [sg\_whitelist\_ips\_office\_nonprod\_http](#input\_sg\_whitelist\_ips\_office\_nonprod\_http) | IP whitelist of office HTTP traffic for NON-PRODUCTION | <pre>list(object({<br>    desc        = string<br>    cidr_blocks = string<br>  }))</pre> | `[]` | no |
| <a name="input_sg_whitelist_ips_office_nonprod_https"></a> [sg\_whitelist\_ips\_office\_nonprod\_https](#input\_sg\_whitelist\_ips\_office\_nonprod\_https) | IP whitelist of office HTTPS traffic for NON-PRODUCTION | <pre>list(object({<br>    desc        = string<br>    cidr_blocks = string<br>  }))</pre> | `[]` | no |
| <a name="input_sg_whitelist_ips_office_production"></a> [sg\_whitelist\_ips\_office\_production](#input\_sg\_whitelist\_ips\_office\_production) | IP whitelist of office HTTPS/HTTP traffic for PRODUCTION | <pre>list(object({<br>    desc        = string<br>    cidr_blocks = string<br>  }))</pre> | `[]` | no |
| <a name="input_sg_whitelist_ips_outside_nonprod_https"></a> [sg\_whitelist\_ips\_outside\_nonprod\_https](#input\_sg\_whitelist\_ips\_outside\_nonprod\_https) | IP whitelist of outside HTTPS traffic for NON-PRODUCTION | <pre>list(object({<br>    desc        = string<br>    cidr_blocks = string<br>  }))</pre> | `[]` | no |
| <a name="input_vpc_pub_az_end"></a> [vpc\_pub\_az\_end](#input\_vpc\_pub\_az\_end) | n/a | `number` | `3` | no |
| <a name="input_vpc_pub_az_start"></a> [vpc\_pub\_az\_start](#input\_vpc\_pub\_az\_start) | n/a | `number` | `0` | no |
| <a name="input_vpc_pub_cidr"></a> [vpc\_pub\_cidr](#input\_vpc\_pub\_cidr) | Public | `string` | `"172.26.0.0/16"` | no |
| <a name="input_vpc_pub_nat_eip_ids"></a> [vpc\_pub\_nat\_eip\_ids](#input\_vpc\_pub\_nat\_eip\_ids) | n/a | `list(string)` | <pre>[<br>  "eipalloc-xxxxxxxxxxxxxxxxx",<br>  "eipalloc-xxxxxxxxxxxxxxxxx",<br>  "eipalloc-xxxxxxxxxxxxxxxxx"<br>]</pre> | no |
| <a name="input_vpc_pub_pri_subnets"></a> [vpc\_pub\_pri\_subnets](#input\_vpc\_pub\_pri\_subnets) | n/a | `list(string)` | <pre>[<br>  "172.26.16.0/23",<br>  "172.26.18.0/23",<br>  "172.26.20.0/23"<br>]</pre> | no |
| <a name="input_vpc_pub_pub_subnets"></a> [vpc\_pub\_pub\_subnets](#input\_vpc\_pub\_pub\_subnets) | n/a | `list(string)` | <pre>[<br>  "172.26.0.0/23",<br>  "172.26.2.0/23",<br>  "172.26.4.0/23",<br>  "172.26.6.0/23",<br>  "172.26.8.0/23",<br>  "172.26.10.0/23"<br>]</pre> | no |
| <a name="input_vpc_pub_reuse_nat_ips"></a> [vpc\_pub\_reuse\_nat\_ips](#input\_vpc\_pub\_reuse\_nat\_ips) | n/a | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_stp-vpc-pub-private-subnet-ids"></a> [stp-vpc-pub-private-subnet-ids](#output\_stp-vpc-pub-private-subnet-ids) | n/a |
| <a name="output_stp-vpc-pub-public-subnet-ids"></a> [stp-vpc-pub-public-subnet-ids](#output\_stp-vpc-pub-public-subnet-ids) | n/a |
| <a name="output_vpc-pub-id"></a> [vpc-pub-id](#output\_vpc-pub-id) | n/a |
| <a name="output_vpc_pub"></a> [vpc\_pub](#output\_vpc\_pub) | ######## Output ######## |
<!-- END_TF_DOCS -->