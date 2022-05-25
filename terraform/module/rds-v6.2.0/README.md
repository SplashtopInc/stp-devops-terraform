<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.10.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_db1"></a> [db1](#module\_db1) | terraform-aws-modules/rds-aurora/aws | 6.2.0 |
| <a name="module_db2"></a> [db2](#module\_db2) | terraform-aws-modules/rds-aurora/aws | 6.2.0 |

## Resources

| Name | Type |
|------|------|
| [aws_db_parameter_group.db1_parameter_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_parameter_group.db2_parameter_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_rds_cluster_parameter_group.db1_cluster_parameter_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_parameter_group) | resource |
| [aws_rds_cluster_parameter_group.db2_cluster_parameter_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_parameter_group) | resource |
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_subnet_ids.stp-vpc-db-all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) | data source |
| [aws_vpc.stp-vpc-db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aurora_description"></a> [aurora\_description](#input\_aurora\_description) | n/a | `string` | `"Splashtop Customized"` | no |
| <a name="input_aurora_mysql_family"></a> [aurora\_mysql\_family](#input\_aurora\_mysql\_family) | ## Aurora RDS ### | `string` | `"aurora-mysql5.7"` | no |
| <a name="input_cluster_name_env"></a> [cluster\_name\_env](#input\_cluster\_name\_env) | n/a | `string` | `""` | no |
| <a name="input_cluster_name_region"></a> [cluster\_name\_region](#input\_cluster\_name\_region) | n/a | `string` | `""` | no |
| <a name="input_db1_cluster_parameters"></a> [db1\_cluster\_parameters](#input\_db1\_cluster\_parameters) | Aurora Cluster DB1 Cluster Parameter Group settings | <pre>list(object({<br>    name         = string<br>    value        = string<br>    apply_method = string<br>  }))</pre> | `[]` | no |
| <a name="input_db1_db_parameters"></a> [db1\_db\_parameters](#input\_db1\_db\_parameters) | Aurora Cluster DB1 DB Parameter Group settings | <pre>list(object({<br>    name         = string<br>    value        = string<br>    apply_method = string<br>  }))</pre> | `[]` | no |
| <a name="input_db2_cluster_parameters"></a> [db2\_cluster\_parameters](#input\_db2\_cluster\_parameters) | Aurora Cluster DB2 Cluster Parameter Group settings | <pre>list(object({<br>    name         = string<br>    value        = string<br>    apply_method = string<br>  }))</pre> | `[]` | no |
| <a name="input_db2_db_parameters"></a> [db2\_db\_parameters](#input\_db2\_db\_parameters) | Aurora Cluster DB2 DB Parameter Group settings | <pre>list(object({<br>    name         = string<br>    value        = string<br>    apply_method = string<br>  }))</pre> | `[]` | no |
| <a name="input_db2_enable"></a> [db2\_enable](#input\_db2\_enable) | ## Aurora RDS ### | `bool` | `true` | no |
| <a name="input_db_backup_retention_period"></a> [db\_backup\_retention\_period](#input\_db\_backup\_retention\_period) | n/a | `number` | `35` | no |
| <a name="input_db_deletion_protection"></a> [db\_deletion\_protection](#input\_db\_deletion\_protection) | n/a | `bool` | `true` | no |
| <a name="input_db_engine_version"></a> [db\_engine\_version](#input\_db\_engine\_version) | n/a | `string` | `""` | no |
| <a name="input_db_instance_class"></a> [db\_instance\_class](#input\_db\_instance\_class) | n/a | `string` | `""` | no |
| <a name="input_db_instances"></a> [db\_instances](#input\_db\_instances) | n/a | `any` | `{}` | no |
| <a name="input_db_master_random_password_length"></a> [db\_master\_random\_password\_length](#input\_db\_master\_random\_password\_length) | n/a | `number` | `20` | no |
| <a name="input_db_master_username"></a> [db\_master\_username](#input\_db\_master\_username) | n/a | `string` | `"berdsadmin"` | no |
| <a name="input_db_preferred_backup_window"></a> [db\_preferred\_backup\_window](#input\_db\_preferred\_backup\_window) | n/a | `string` | `""` | no |
| <a name="input_db_preferred_maintenance_window"></a> [db\_preferred\_maintenance\_window](#input\_db\_preferred\_maintenance\_window) | n/a | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `""` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | n/a | `string` | `"user"` | no |
| <a name="input_project"></a> [project](#input\_project) | n/a | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | ## Site information ### | `string` | `""` | no |
| <a name="input_vpc-db-all-subnets"></a> [vpc-db-all-subnets](#input\_vpc-db-all-subnets) | n/a | `list(string)` | `[]` | no |
| <a name="input_vpc_db_vpc_id"></a> [vpc\_db\_vpc\_id](#input\_vpc\_db\_vpc\_id) | n/a | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_Aurora-Cluster-DB1"></a> [Aurora-Cluster-DB1](#output\_Aurora-Cluster-DB1) | n/a |
| <a name="output_Aurora-Cluster-DB2"></a> [Aurora-Cluster-DB2](#output\_Aurora-Cluster-DB2) | n/a |
| <a name="output_DB-Password"></a> [DB-Password](#output\_DB-Password) | n/a |
| <a name="output_db1"></a> [db1](#output\_db1) | ## Output ### |
| <a name="output_db2"></a> [db2](#output\_db2) | n/a |
<!-- END_TF_DOCS -->