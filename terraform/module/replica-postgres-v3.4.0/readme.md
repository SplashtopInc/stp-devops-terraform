# Complete RDS example for PostgreSQL

Configuration in this directory creates a set of RDS resources including DB instance, DB subnet group and DB parameter group.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_master"></a> [master](#module\_master) | terraform-aws-modules/rds/aws | 3.4.0 |
| <a name="module_replica"></a> [replica](#module\_replica) | terraform-aws-modules/rds/aws | 3.4.0 |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | terraform-aws-modules/security-group/aws | ~> 4 |

## Resources

| Name | Type |
|------|------|
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | The allocated storage in gigabytes | `number` | `20` | no |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | n/a | `string` | `"app"` | no |
| <a name="input_assume_role"></a> [assume\_role](#input\_assume\_role) | n/a | `string` | `""` | no |
| <a name="input_cidr_blocks"></a> [cidr\_blocks](#input\_cidr\_blocks) | cidr range for db | `string` | `"10.117.0.0/16"` | no |
| <a name="input_create_random_password"></a> [create\_random\_password](#input\_create\_random\_password) | Whether to create random password for RDS primary cluster | `bool` | `true` | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | The DB name to create. If omitted, no database is created initially | `string` | `"sonarDB"` | no |
| <a name="input_db_pass"></a> [db\_pass](#input\_db\_pass) | Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file | `string` | `"sonarPass"` | no |
| <a name="input_db_subnet_group_name"></a> [db\_subnet\_group\_name](#input\_db\_subnet\_group\_name) | Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC | `string` | `""` | no |
| <a name="input_db_user"></a> [db\_user](#input\_db\_user) | Username for the master DB user | `string` | `"sonarUser"` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | The database can't be deleted when this value is set to true | `bool` | `true` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | The database engine to use | `string` | `"postgres"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The engine version to use | `string` | `"13.2"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `""` | no |
| <a name="input_family"></a> [family](#input\_family) | The family of the DB parameter group | `string` | `"postgres13"` | no |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | The instance type of the RDS instance | `string` | `"db.t3.medium"` | no |
| <a name="input_major_engine_version"></a> [major\_engine\_version](#input\_major\_engine\_version) | Specifies the major version of the engine that this option group should be associated with | `string` | `"14"` | no |
| <a name="input_max_allocated_storage"></a> [max\_allocated\_storage](#input\_max\_allocated\_storage) | Specifies the value for Storage Autoscaling | `number` | `100` | no |
| <a name="input_port"></a> [port](#input\_port) | The port on which the DB accepts connections | `number` | `5432` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | AWS privilege | `string` | `""` | no |
| <a name="input_project"></a> [project](#input\_project) | n/a | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `""` | no |
| <a name="input_storage_encrypted"></a> [storage\_encrypted](#input\_storage\_encrypted) | Specifies whether the DB instance is encrypted | `bool` | `true` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | vpc module outputs the ID under the name vpc\_id | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_master_db_instance_address"></a> [master\_db\_instance\_address](#output\_master\_db\_instance\_address) | The address of the RDS instance |
| <a name="output_master_db_instance_arn"></a> [master\_db\_instance\_arn](#output\_master\_db\_instance\_arn) | The ARN of the RDS instance |
| <a name="output_master_db_instance_availability_zone"></a> [master\_db\_instance\_availability\_zone](#output\_master\_db\_instance\_availability\_zone) | The availability zone of the RDS instance |
| <a name="output_master_db_instance_endpoint"></a> [master\_db\_instance\_endpoint](#output\_master\_db\_instance\_endpoint) | The connection endpoint |
| <a name="output_master_db_instance_hosted_zone_id"></a> [master\_db\_instance\_hosted\_zone\_id](#output\_master\_db\_instance\_hosted\_zone\_id) | The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record) |
| <a name="output_master_db_instance_id"></a> [master\_db\_instance\_id](#output\_master\_db\_instance\_id) | The RDS instance ID |
| <a name="output_master_db_instance_name"></a> [master\_db\_instance\_name](#output\_master\_db\_instance\_name) | The database name |
| <a name="output_master_db_instance_password"></a> [master\_db\_instance\_password](#output\_master\_db\_instance\_password) | The database password (this password may be old, because Terraform doesn't track it after initial creation) |
| <a name="output_master_db_instance_port"></a> [master\_db\_instance\_port](#output\_master\_db\_instance\_port) | The database port |
| <a name="output_master_db_instance_resource_id"></a> [master\_db\_instance\_resource\_id](#output\_master\_db\_instance\_resource\_id) | The RDS Resource ID of this instance |
| <a name="output_master_db_instance_status"></a> [master\_db\_instance\_status](#output\_master\_db\_instance\_status) | The RDS instance status |
| <a name="output_master_db_instance_username"></a> [master\_db\_instance\_username](#output\_master\_db\_instance\_username) | The master username for the database |
| <a name="output_master_db_subnet_group_arn"></a> [master\_db\_subnet\_group\_arn](#output\_master\_db\_subnet\_group\_arn) | The ARN of the db subnet group |
| <a name="output_master_db_subnet_group_id"></a> [master\_db\_subnet\_group\_id](#output\_master\_db\_subnet\_group\_id) | The db subnet group name |
| <a name="output_replica_db_instance_address"></a> [replica\_db\_instance\_address](#output\_replica\_db\_instance\_address) | The address of the RDS instance |
| <a name="output_replica_db_instance_arn"></a> [replica\_db\_instance\_arn](#output\_replica\_db\_instance\_arn) | The ARN of the RDS instance |
| <a name="output_replica_db_instance_availability_zone"></a> [replica\_db\_instance\_availability\_zone](#output\_replica\_db\_instance\_availability\_zone) | The availability zone of the RDS instance |
| <a name="output_replica_db_instance_endpoint"></a> [replica\_db\_instance\_endpoint](#output\_replica\_db\_instance\_endpoint) | The connection endpoint |
| <a name="output_replica_db_instance_hosted_zone_id"></a> [replica\_db\_instance\_hosted\_zone\_id](#output\_replica\_db\_instance\_hosted\_zone\_id) | The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record) |
| <a name="output_replica_db_instance_id"></a> [replica\_db\_instance\_id](#output\_replica\_db\_instance\_id) | The RDS instance ID |
| <a name="output_replica_db_instance_name"></a> [replica\_db\_instance\_name](#output\_replica\_db\_instance\_name) | The database name |
| <a name="output_replica_db_instance_port"></a> [replica\_db\_instance\_port](#output\_replica\_db\_instance\_port) | The database port |
| <a name="output_replica_db_instance_resource_id"></a> [replica\_db\_instance\_resource\_id](#output\_replica\_db\_instance\_resource\_id) | The RDS Resource ID of this instance |
| <a name="output_replica_db_instance_status"></a> [replica\_db\_instance\_status](#output\_replica\_db\_instance\_status) | The RDS instance status |
| <a name="output_replica_db_instance_username"></a> [replica\_db\_instance\_username](#output\_replica\_db\_instance\_username) | The replica username for the database |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_master"></a> [master](#module\_master) | terraform-aws-modules/rds/aws | 3.4.0 |
| <a name="module_replica"></a> [replica](#module\_replica) | terraform-aws-modules/rds/aws | 3.4.0 |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | terraform-aws-modules/security-group/aws | ~> 4 |

## Resources

| Name | Type |
|------|------|
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | The allocated storage in gigabytes | `number` | `20` | no |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | n/a | `string` | `"app"` | no |
| <a name="input_assume_role"></a> [assume\_role](#input\_assume\_role) | n/a | `string` | `""` | no |
| <a name="input_cidr_blocks"></a> [cidr\_blocks](#input\_cidr\_blocks) | cidr range for db | `string` | `"10.117.0.0/16"` | no |
| <a name="input_create_random_password"></a> [create\_random\_password](#input\_create\_random\_password) | Whether to create random password for RDS primary cluster | `bool` | `true` | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | The DB name to create. If omitted, no database is created initially | `string` | `"sonarDB"` | no |
| <a name="input_db_pass"></a> [db\_pass](#input\_db\_pass) | Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file | `string` | `"sonarPass"` | no |
| <a name="input_db_subnet_group_name"></a> [db\_subnet\_group\_name](#input\_db\_subnet\_group\_name) | Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC | `string` | `""` | no |
| <a name="input_db_user"></a> [db\_user](#input\_db\_user) | Username for the master DB user | `string` | `"sonarUser"` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | The database can't be deleted when this value is set to true | `bool` | `true` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | The database engine to use | `string` | `"postgres"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The engine version to use | `string` | `"13.2"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `""` | no |
| <a name="input_family"></a> [family](#input\_family) | The family of the DB parameter group | `string` | `"postgres13"` | no |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | The instance type of the RDS instance | `string` | `"db.t3.medium"` | no |
| <a name="input_major_engine_version"></a> [major\_engine\_version](#input\_major\_engine\_version) | Specifies the major version of the engine that this option group should be associated with | `string` | `"14"` | no |
| <a name="input_max_allocated_storage"></a> [max\_allocated\_storage](#input\_max\_allocated\_storage) | Specifies the value for Storage Autoscaling | `number` | `100` | no |
| <a name="input_port"></a> [port](#input\_port) | The port on which the DB accepts connections | `number` | `5432` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | AWS privilege | `string` | `""` | no |
| <a name="input_project"></a> [project](#input\_project) | n/a | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `""` | no |
| <a name="input_storage_encrypted"></a> [storage\_encrypted](#input\_storage\_encrypted) | Specifies whether the DB instance is encrypted | `bool` | `true` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | vpc module outputs the ID under the name vpc\_id | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_master_db_instance_address"></a> [master\_db\_instance\_address](#output\_master\_db\_instance\_address) | The address of the RDS instance |
| <a name="output_master_db_instance_arn"></a> [master\_db\_instance\_arn](#output\_master\_db\_instance\_arn) | The ARN of the RDS instance |
| <a name="output_master_db_instance_availability_zone"></a> [master\_db\_instance\_availability\_zone](#output\_master\_db\_instance\_availability\_zone) | The availability zone of the RDS instance |
| <a name="output_master_db_instance_endpoint"></a> [master\_db\_instance\_endpoint](#output\_master\_db\_instance\_endpoint) | The connection endpoint |
| <a name="output_master_db_instance_hosted_zone_id"></a> [master\_db\_instance\_hosted\_zone\_id](#output\_master\_db\_instance\_hosted\_zone\_id) | The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record) |
| <a name="output_master_db_instance_id"></a> [master\_db\_instance\_id](#output\_master\_db\_instance\_id) | The RDS instance ID |
| <a name="output_master_db_instance_name"></a> [master\_db\_instance\_name](#output\_master\_db\_instance\_name) | The database name |
| <a name="output_master_db_instance_password"></a> [master\_db\_instance\_password](#output\_master\_db\_instance\_password) | The database password (this password may be old, because Terraform doesn't track it after initial creation) |
| <a name="output_master_db_instance_port"></a> [master\_db\_instance\_port](#output\_master\_db\_instance\_port) | The database port |
| <a name="output_master_db_instance_resource_id"></a> [master\_db\_instance\_resource\_id](#output\_master\_db\_instance\_resource\_id) | The RDS Resource ID of this instance |
| <a name="output_master_db_instance_status"></a> [master\_db\_instance\_status](#output\_master\_db\_instance\_status) | The RDS instance status |
| <a name="output_master_db_instance_username"></a> [master\_db\_instance\_username](#output\_master\_db\_instance\_username) | The master username for the database |
| <a name="output_master_db_subnet_group_arn"></a> [master\_db\_subnet\_group\_arn](#output\_master\_db\_subnet\_group\_arn) | The ARN of the db subnet group |
| <a name="output_master_db_subnet_group_id"></a> [master\_db\_subnet\_group\_id](#output\_master\_db\_subnet\_group\_id) | The db subnet group name |
| <a name="output_replica_db_instance_address"></a> [replica\_db\_instance\_address](#output\_replica\_db\_instance\_address) | The address of the RDS instance |
| <a name="output_replica_db_instance_arn"></a> [replica\_db\_instance\_arn](#output\_replica\_db\_instance\_arn) | The ARN of the RDS instance |
| <a name="output_replica_db_instance_availability_zone"></a> [replica\_db\_instance\_availability\_zone](#output\_replica\_db\_instance\_availability\_zone) | The availability zone of the RDS instance |
| <a name="output_replica_db_instance_endpoint"></a> [replica\_db\_instance\_endpoint](#output\_replica\_db\_instance\_endpoint) | The connection endpoint |
| <a name="output_replica_db_instance_hosted_zone_id"></a> [replica\_db\_instance\_hosted\_zone\_id](#output\_replica\_db\_instance\_hosted\_zone\_id) | The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record) |
| <a name="output_replica_db_instance_id"></a> [replica\_db\_instance\_id](#output\_replica\_db\_instance\_id) | The RDS instance ID |
| <a name="output_replica_db_instance_name"></a> [replica\_db\_instance\_name](#output\_replica\_db\_instance\_name) | The database name |
| <a name="output_replica_db_instance_port"></a> [replica\_db\_instance\_port](#output\_replica\_db\_instance\_port) | The database port |
| <a name="output_replica_db_instance_resource_id"></a> [replica\_db\_instance\_resource\_id](#output\_replica\_db\_instance\_resource\_id) | The RDS Resource ID of this instance |
| <a name="output_replica_db_instance_status"></a> [replica\_db\_instance\_status](#output\_replica\_db\_instance\_status) | The RDS instance status |
| <a name="output_replica_db_instance_username"></a> [replica\_db\_instance\_username](#output\_replica\_db\_instance\_username) | The replica username for the database |
<!-- END_TF_DOCS -->