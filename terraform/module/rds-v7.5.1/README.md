<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.30 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 2.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.30 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 2.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_db1"></a> [db1](#module\_db1) | terraform-aws-modules/rds-aurora/aws | 7.5.1 |
| <a name="module_db2"></a> [db2](#module\_db2) | terraform-aws-modules/rds-aurora/aws | 7.5.1 |

## Resources

| Name | Type |
|------|------|
| [random_password.master](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_subnets.stp-vpc-db-all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.stp-vpc-db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_major_version_upgrade"></a> [allow\_major\_version\_upgrade](#input\_allow\_major\_version\_upgrade) | Enable to allow major engine version upgrades when changing engine versions. Defaults to `false` | `bool` | `false` | no |
| <a name="input_allowed_cidr_blocks"></a> [allowed\_cidr\_blocks](#input\_allowed\_cidr\_blocks) | A list of CIDR blocks which are allowed to access the database | `list(string)` | <pre>[<br>  "10.0.0.0/8",<br>  "172.16.0.0/12",<br>  "192.168.0.0/16"<br>]</pre> | no |
| <a name="input_allowed_security_groups"></a> [allowed\_security\_groups](#input\_allowed\_security\_groups) | A list of Security Group ID's to allow access to | `list(string)` | `[]` | no |
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | Specifies whether any cluster modifications are applied immediately, or during the next maintenance window. Default is `false` | `bool` | `null` | no |
| <a name="input_assume_role"></a> [assume\_role](#input\_assume\_role) | the aws role to be assigned to | `string` | `""` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window. Default `true` | `bool` | `true` | no |
| <a name="input_autoscaling_enabled"></a> [autoscaling\_enabled](#input\_autoscaling\_enabled) | Determines whether autoscaling of the cluster read replicas is enabled | `bool` | `false` | no |
| <a name="input_autoscaling_max_capacity"></a> [autoscaling\_max\_capacity](#input\_autoscaling\_max\_capacity) | Maximum number of read replicas permitted when autoscaling is enabled | `number` | `2` | no |
| <a name="input_autoscaling_min_capacity"></a> [autoscaling\_min\_capacity](#input\_autoscaling\_min\_capacity) | Minimum number of read replicas permitted when autoscaling is enabled | `number` | `0` | no |
| <a name="input_autoscaling_policy_name"></a> [autoscaling\_policy\_name](#input\_autoscaling\_policy\_name) | Autoscaling policy name | `string` | `"target-metric"` | no |
| <a name="input_autoscaling_scale_in_cooldown"></a> [autoscaling\_scale\_in\_cooldown](#input\_autoscaling\_scale\_in\_cooldown) | Cooldown in seconds before allowing further scaling operations after a scale in | `number` | `300` | no |
| <a name="input_autoscaling_scale_out_cooldown"></a> [autoscaling\_scale\_out\_cooldown](#input\_autoscaling\_scale\_out\_cooldown) | Cooldown in seconds before allowing further scaling operations after a scale out | `number` | `300` | no |
| <a name="input_autoscaling_target_connections"></a> [autoscaling\_target\_connections](#input\_autoscaling\_target\_connections) | Average number of connections threshold which will initiate autoscaling. Default value is 70% of db.r4/r5/r6g.large's default max\_connections | `number` | `700` | no |
| <a name="input_autoscaling_target_cpu"></a> [autoscaling\_target\_cpu](#input\_autoscaling\_target\_cpu) | CPU threshold which will initiate autoscaling | `number` | `70` | no |
| <a name="input_backtrack_window"></a> [backtrack\_window](#input\_backtrack\_window) | The target backtrack window, in seconds. Only available for `aurora` engine currently. To disable backtracking, set this value to 0. Must be between 0 and 259200 (72 hours) | `number` | `null` | no |
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | The days to retain backups for. Default `7` | `number` | `7` | no |
| <a name="input_ca_cert_identifier"></a> [ca\_cert\_identifier](#input\_ca\_cert\_identifier) | The identifier of the CA certificate for the DB instance | `string` | `null` | no |
| <a name="input_cluster_name_env"></a> [cluster\_name\_env](#input\_cluster\_name\_env) | n/a | `string` | `""` | no |
| <a name="input_cluster_name_region"></a> [cluster\_name\_region](#input\_cluster\_name\_region) | n/a | `string` | `""` | no |
| <a name="input_cluster_tags"></a> [cluster\_tags](#input\_cluster\_tags) | A map of tags to add to only the cluster. Used for AWS Instance Scheduler tagging | `map(string)` | `{}` | no |
| <a name="input_cluster_timeouts"></a> [cluster\_timeouts](#input\_cluster\_timeouts) | Create, update, and delete timeout configurations for the cluster | `map(string)` | `{}` | no |
| <a name="input_copy_tags_to_snapshot"></a> [copy\_tags\_to\_snapshot](#input\_copy\_tags\_to\_snapshot) | Copy all Cluster `tags` to snapshots | `bool` | `null` | no |
| <a name="input_create_cluster"></a> [create\_cluster](#input\_create\_cluster) | Whether cluster should be created (affects nearly all resources) | `bool` | `true` | no |
| <a name="input_create_db_cluster_parameter_group"></a> [create\_db\_cluster\_parameter\_group](#input\_create\_db\_cluster\_parameter\_group) | Determines whether a cluster parameter should be created or use existing | `bool` | `false` | no |
| <a name="input_create_db_parameter_group"></a> [create\_db\_parameter\_group](#input\_create\_db\_parameter\_group) | Determines whether a DB parameter should be created or use existing | `bool` | `false` | no |
| <a name="input_create_db_subnet_group"></a> [create\_db\_subnet\_group](#input\_create\_db\_subnet\_group) | Determines whether to create the database subnet group or use existing | `bool` | `true` | no |
| <a name="input_create_monitoring_role"></a> [create\_monitoring\_role](#input\_create\_monitoring\_role) | Determines whether to create the IAM role for RDS enhanced monitoring | `bool` | `true` | no |
| <a name="input_create_random_password"></a> [create\_random\_password](#input\_create\_random\_password) | Determines whether to create random password for RDS primary cluster | `bool` | `true` | no |
| <a name="input_create_security_group"></a> [create\_security\_group](#input\_create\_security\_group) | Determines whether to create security group for RDS cluster | `bool` | `true` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | Name for an automatically created database on cluster creation | `string` | `null` | no |
| <a name="input_db1_cluster_parameters"></a> [db1\_cluster\_parameters](#input\_db1\_cluster\_parameters) | Aurora Cluster DB1 Cluster Parameter Group settings | <pre>list(object({<br>    name         = string<br>    value        = string<br>    apply_method = string<br>  }))</pre> | <pre>[<br>  {<br>    "apply_method": "immediate",<br>    "name": "connect_timeout",<br>    "value": "720"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "innodb_lock_wait_timeout",<br>    "value": "3600"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "innodb_print_all_deadlocks",<br>    "value": "1"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "innodb_stats_auto_recalc",<br>    "value": "0"<br>  },<br>  {<br>    "apply_method": "pending-reboot",<br>    "name": "innodb_sync_array_size",<br>    "value": "16"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "interactive_timeout",<br>    "value": "10800"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "lock_wait_timeout",<br>    "value": "3600"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "log_bin_trust_function_creators",<br>    "value": "1"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "log_error_verbosity",<br>    "value": "2"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "log_queries_not_using_indexes",<br>    "value": "0"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "log_throttle_queries_not_using_indexes",<br>    "value": "1000"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "long_query_time",<br>    "value": "0.02"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "max_allowed_packet",<br>    "value": "8388608"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "max_connections",<br>    "value": "9000"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "min_examined_row_limit",<br>    "value": "1"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "net_read_timeout",<br>    "value": "120"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "net_write_timeout",<br>    "value": "120"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "server_audit_events",<br>    "value": "CONNECT,QUERY_DCL,QUERY_DDL"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "server_audit_excl_users",<br>    "value": "rdsadmin"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "server_audit_logging",<br>    "value": "1"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "server_audit_logs_upload",<br>    "value": "1"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "slow_query_log",<br>    "value": "1"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "wait_timeout",<br>    "value": "3600"<br>  }<br>]</pre> | no |
| <a name="input_db1_db_parameters"></a> [db1\_db\_parameters](#input\_db1\_db\_parameters) | Aurora Cluster DB1 DB Parameter Group settings | <pre>list(object({<br>    name         = string<br>    value        = string<br>    apply_method = string<br>  }))</pre> | `[]` | no |
| <a name="input_db1_enable"></a> [db1\_enable](#input\_db1\_enable) | Whether cluster should be created (affects nearly all resources) | `bool` | `true` | no |
| <a name="input_db2_cluster_parameters"></a> [db2\_cluster\_parameters](#input\_db2\_cluster\_parameters) | Aurora Cluster DB2 Cluster Parameter Group settings | <pre>list(object({<br>    name         = string<br>    value        = string<br>    apply_method = string<br>  }))</pre> | <pre>[<br>  {<br>    "apply_method": "immediate",<br>    "name": "connect_timeout",<br>    "value": "720"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "innodb_lock_wait_timeout",<br>    "value": "3600"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "innodb_print_all_deadlocks",<br>    "value": "1"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "innodb_stats_auto_recalc",<br>    "value": "0"<br>  },<br>  {<br>    "apply_method": "pending-reboot",<br>    "name": "innodb_sync_array_size",<br>    "value": "16"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "interactive_timeout",<br>    "value": "3600"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "lock_wait_timeout",<br>    "value": "3600"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "log_bin_trust_function_creators",<br>    "value": "1"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "log_error_verbosity",<br>    "value": "2"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "log_queries_not_using_indexes",<br>    "value": "0"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "log_throttle_queries_not_using_indexes",<br>    "value": "1000"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "long_query_time",<br>    "value": "0.02"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "max_allowed_packet",<br>    "value": "8388608"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "max_connections",<br>    "value": "9000"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "min_examined_row_limit",<br>    "value": "1"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "net_read_timeout",<br>    "value": "120"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "net_write_timeout",<br>    "value": "120"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "server_audit_events",<br>    "value": "CONNECT,QUERY_DCL,QUERY_DDL"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "server_audit_excl_users",<br>    "value": "rdsadmin"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "server_audit_logging",<br>    "value": "1"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "server_audit_logs_upload",<br>    "value": "1"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "slow_query_log",<br>    "value": "1"<br>  },<br>  {<br>    "apply_method": "immediate",<br>    "name": "wait_timeout",<br>    "value": "3600"<br>  }<br>]</pre> | no |
| <a name="input_db2_db_parameters"></a> [db2\_db\_parameters](#input\_db2\_db\_parameters) | Aurora Cluster DB2 DB Parameter Group settings | <pre>list(object({<br>    name         = string<br>    value        = string<br>    apply_method = string<br>  }))</pre> | `[]` | no |
| <a name="input_db2_enable"></a> [db2\_enable](#input\_db2\_enable) | Whether cluster should be created (affects nearly all resources) | `bool` | `true` | no |
| <a name="input_db_cluster_db_instance_parameter_group_name"></a> [db\_cluster\_db\_instance\_parameter\_group\_name](#input\_db\_cluster\_db\_instance\_parameter\_group\_name) | Instance parameter group to associate with all instances of the DB cluster. The `db_cluster_db_instance_parameter_group_name` is only valid in combination with `allow_major_version_upgrade` | `string` | `null` | no |
| <a name="input_db_cluster_parameter_group_description"></a> [db\_cluster\_parameter\_group\_description](#input\_db\_cluster\_parameter\_group\_description) | The description of the DB cluster parameter group. Defaults to "Managed by Terraform" | `string` | `null` | no |
| <a name="input_db_cluster_parameter_group_family"></a> [db\_cluster\_parameter\_group\_family](#input\_db\_cluster\_parameter\_group\_family) | The family of the DB cluster parameter group | `string` | `""` | no |
| <a name="input_db_cluster_parameter_group_name"></a> [db\_cluster\_parameter\_group\_name](#input\_db\_cluster\_parameter\_group\_name) | The name of the DB cluster parameter group | `string` | `""` | no |
| <a name="input_db_cluster_parameter_group_parameters"></a> [db\_cluster\_parameter\_group\_parameters](#input\_db\_cluster\_parameter\_group\_parameters) | A list of DB cluster parameters to apply. Note that parameters may differ from a family to an other | `list(map(string))` | `[]` | no |
| <a name="input_db_cluster_parameter_group_use_name_prefix"></a> [db\_cluster\_parameter\_group\_use\_name\_prefix](#input\_db\_cluster\_parameter\_group\_use\_name\_prefix) | Determines whether the DB cluster parameter group name is used as a prefix | `bool` | `true` | no |
| <a name="input_db_parameter_group_description"></a> [db\_parameter\_group\_description](#input\_db\_parameter\_group\_description) | The description of the DB parameter group. Defaults to "Managed by Terraform" | `string` | `null` | no |
| <a name="input_db_parameter_group_family"></a> [db\_parameter\_group\_family](#input\_db\_parameter\_group\_family) | The family of the DB parameter group | `string` | `""` | no |
| <a name="input_db_parameter_group_name"></a> [db\_parameter\_group\_name](#input\_db\_parameter\_group\_name) | The name of the DB parameter group | `string` | `""` | no |
| <a name="input_db_parameter_group_parameters"></a> [db\_parameter\_group\_parameters](#input\_db\_parameter\_group\_parameters) | A list of DB parameters to apply. Note that parameters may differ from a family to an other | `list(map(string))` | `[]` | no |
| <a name="input_db_parameter_group_use_name_prefix"></a> [db\_parameter\_group\_use\_name\_prefix](#input\_db\_parameter\_group\_use\_name\_prefix) | Determines whether the DB parameter group name is used as a prefix | `bool` | `true` | no |
| <a name="input_db_subnet_group_name"></a> [db\_subnet\_group\_name](#input\_db\_subnet\_group\_name) | The name of the subnet group name (existing or created) | `string` | `""` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to `true`. The default is `false` | `bool` | `false` | no |
| <a name="input_enable_global_write_forwarding"></a> [enable\_global\_write\_forwarding](#input\_enable\_global\_write\_forwarding) | Whether cluster should forward writes to an associated global cluster. Applied to secondary clusters to enable them to forward writes to an `aws_rds_global_cluster`'s primary cluster | `bool` | `null` | no |
| <a name="input_enable_http_endpoint"></a> [enable\_http\_endpoint](#input\_enable\_http\_endpoint) | Enable HTTP endpoint (data API). Only valid when engine\_mode is set to `serverless` | `bool` | `null` | no |
| <a name="input_enabled_cloudwatch_logs_exports"></a> [enabled\_cloudwatch\_logs\_exports](#input\_enabled\_cloudwatch\_logs\_exports) | Set of log types to export to cloudwatch. If omitted, no logs will be exported. The following log types are supported: `audit`, `error`, `general`, `slowquery`, `postgresql` | `list(string)` | `[]` | no |
| <a name="input_endpoints"></a> [endpoints](#input\_endpoints) | Map of additional cluster endpoints and their attributes to be created | `any` | `{}` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | The name of the database engine to be used for this DB cluster. Defaults to `aurora`. Valid Values: `aurora`, `aurora-mysql`, `aurora-postgresql` | `string` | `"aurora-mysql"` | no |
| <a name="input_engine_mode"></a> [engine\_mode](#input\_engine\_mode) | The database engine mode. Valid values: `global`, `multimaster`, `parallelquery`, `provisioned`, `serverless`. Defaults to: `provisioned` | `string` | `null` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The database engine version. Updating this argument results in an outage | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | the environment ex: prod, qa, test | `string` | `""` | no |
| <a name="input_final_snapshot_identifier_prefix"></a> [final\_snapshot\_identifier\_prefix](#input\_final\_snapshot\_identifier\_prefix) | The prefix name to use when creating a final snapshot on cluster destroy; a 8 random digits are appended to name to ensure it's unique | `string` | `"final"` | no |
| <a name="input_global_cluster_identifier"></a> [global\_cluster\_identifier](#input\_global\_cluster\_identifier) | The global cluster identifier specified on `aws_rds_global_cluster` | `string` | `null` | no |
| <a name="input_iam_database_authentication_enabled"></a> [iam\_database\_authentication\_enabled](#input\_iam\_database\_authentication\_enabled) | Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled | `bool` | `false` | no |
| <a name="input_iam_role_description"></a> [iam\_role\_description](#input\_iam\_role\_description) | Description of the monitoring role | `string` | `null` | no |
| <a name="input_iam_role_force_detach_policies"></a> [iam\_role\_force\_detach\_policies](#input\_iam\_role\_force\_detach\_policies) | Whether to force detaching any policies the monitoring role has before destroying it | `bool` | `null` | no |
| <a name="input_iam_role_managed_policy_arns"></a> [iam\_role\_managed\_policy\_arns](#input\_iam\_role\_managed\_policy\_arns) | Set of exclusive IAM managed policy ARNs to attach to the monitoring role | `list(string)` | `null` | no |
| <a name="input_iam_role_max_session_duration"></a> [iam\_role\_max\_session\_duration](#input\_iam\_role\_max\_session\_duration) | Maximum session duration (in seconds) that you want to set for the monitoring role | `number` | `null` | no |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | Friendly name of the monitoring role | `string` | `null` | no |
| <a name="input_iam_role_path"></a> [iam\_role\_path](#input\_iam\_role\_path) | Path for the monitoring role | `string` | `null` | no |
| <a name="input_iam_role_permissions_boundary"></a> [iam\_role\_permissions\_boundary](#input\_iam\_role\_permissions\_boundary) | The ARN of the policy that is used to set the permissions boundary for the monitoring role | `string` | `null` | no |
| <a name="input_iam_role_use_name_prefix"></a> [iam\_role\_use\_name\_prefix](#input\_iam\_role\_use\_name\_prefix) | Determines whether to use `iam_role_name` as is or create a unique name beginning with the `iam_role_name` as the prefix | `bool` | `false` | no |
| <a name="input_iam_roles"></a> [iam\_roles](#input\_iam\_roles) | Map of IAM roles and supported feature names to associate with the cluster | `map(map(string))` | `{}` | no |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | Instance type to use at master instance. Note: if `autoscaling_enabled` is `true`, this will be the same instance class used on instances created by autoscaling | `string` | `"db.t3.medium"` | no |
| <a name="input_instance_timeouts"></a> [instance\_timeouts](#input\_instance\_timeouts) | Create, update, and delete timeout configurations for the cluster instance(s) | `map(string)` | `{}` | no |
| <a name="input_instances"></a> [instances](#input\_instances) | Map of cluster instances and any specific/overriding attributes to be created | `any` | `{}` | no |
| <a name="input_instances_use_identifier_prefix"></a> [instances\_use\_identifier\_prefix](#input\_instances\_use\_identifier\_prefix) | Determines whether cluster instance identifiers are used as prefixes | `bool` | `false` | no |
| <a name="input_is_primary_cluster"></a> [is\_primary\_cluster](#input\_is\_primary\_cluster) | Determines whether cluster is primary cluster with writer instance (set to `false` for global cluster and replica clusters) | `bool` | `true` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The ARN for the KMS encryption key. When specifying `kms_key_id`, `storage_encrypted` needs to be set to `true` | `string` | `null` | no |
| <a name="input_master_password"></a> [master\_password](#input\_master\_password) | Password for the master DB user. Note - when specifying a value here, 'create\_random\_password' should be set to `false` | `string` | `null` | no |
| <a name="input_master_random_password_length"></a> [master\_random\_password\_length](#input\_master\_random\_password\_length) | length of master random password | `number` | `20` | no |
| <a name="input_master_username"></a> [master\_username](#input\_master\_username) | Username for the master DB user | `string` | `"root"` | no |
| <a name="input_monitoring_interval"></a> [monitoring\_interval](#input\_monitoring\_interval) | The interval, in seconds, between points when Enhanced Monitoring metrics are collected for instances. Set to `0` to disble. Default is `0` | `number` | `60` | no |
| <a name="input_monitoring_role_arn"></a> [monitoring\_role\_arn](#input\_monitoring\_role\_arn) | IAM role used by RDS to send enhanced monitoring metrics to CloudWatch | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name used across resources created | `string` | `""` | no |
| <a name="input_performance_insights_enabled"></a> [performance\_insights\_enabled](#input\_performance\_insights\_enabled) | Specifies whether Performance Insights is enabled or not | `bool` | `null` | no |
| <a name="input_performance_insights_kms_key_id"></a> [performance\_insights\_kms\_key\_id](#input\_performance\_insights\_kms\_key\_id) | The ARN for the KMS key to encrypt Performance Insights data | `string` | `null` | no |
| <a name="input_performance_insights_retention_period"></a> [performance\_insights\_retention\_period](#input\_performance\_insights\_retention\_period) | Amount of time in days to retain Performance Insights data. Either 7 (7 days) or 731 (2 years) | `number` | `null` | no |
| <a name="input_port"></a> [port](#input\_port) | The port on which the DB accepts connections | `string` | `null` | no |
| <a name="input_predefined_metric_type"></a> [predefined\_metric\_type](#input\_predefined\_metric\_type) | The metric type to scale on. Valid values are `RDSReaderAverageCPUUtilization` and `RDSReaderAverageDatabaseConnections` | `string` | `"RDSReaderAverageCPUUtilization"` | no |
| <a name="input_preferred_backup_window"></a> [preferred\_backup\_window](#input\_preferred\_backup\_window) | The daily time range during which automated backups are created if automated backups are enabled using the `backup_retention_period` parameter. Time in UTC | `string` | `"02:00-03:00"` | no |
| <a name="input_preferred_maintenance_window"></a> [preferred\_maintenance\_window](#input\_preferred\_maintenance\_window) | The weekly time range during which system maintenance can occur, in (UTC) | `string` | `"sun:05:00-sun:06:00"` | no |
| <a name="input_project"></a> [project](#input\_project) | the project name | `string` | `""` | no |
| <a name="input_publicly_accessible"></a> [publicly\_accessible](#input\_publicly\_accessible) | Determines whether instances are publicly accessible. Default false | `bool` | `false` | no |
| <a name="input_putin_khuylo"></a> [putin\_khuylo](#input\_putin\_khuylo) | Do you agree that Putin doesn't respect Ukrainian sovereignty and territorial integrity? More info: https://en.wikipedia.org/wiki/Putin_khuylo! | `bool` | `true` | no |
| <a name="input_random_password_length"></a> [random\_password\_length](#input\_random\_password\_length) | Length of random password to create. Defaults to `10` | `number` | `10` | no |
| <a name="input_region"></a> [region](#input\_region) | the aws region | `string` | `""` | no |
| <a name="input_replication_source_identifier"></a> [replication\_source\_identifier](#input\_replication\_source\_identifier) | ARN of a source DB cluster or DB instance if this DB cluster is to be created as a Read Replica | `string` | `null` | no |
| <a name="input_restore_to_point_in_time"></a> [restore\_to\_point\_in\_time](#input\_restore\_to\_point\_in\_time) | Map of nested attributes for cloning Aurora cluster | `map(string)` | `{}` | no |
| <a name="input_s3_import"></a> [s3\_import](#input\_s3\_import) | Configuration map used to restore from a Percona Xtrabackup in S3 (only MySQL is supported) | `map(string)` | `null` | no |
| <a name="input_scaling_configuration"></a> [scaling\_configuration](#input\_scaling\_configuration) | Map of nested attributes with scaling properties. Only valid when `engine_mode` is set to `serverless` | `map(string)` | `{}` | no |
| <a name="input_security_group_description"></a> [security\_group\_description](#input\_security\_group\_description) | The description of the security group. If value is set to empty string it will contain cluster name in the description | `string` | `null` | no |
| <a name="input_security_group_egress_rules"></a> [security\_group\_egress\_rules](#input\_security\_group\_egress\_rules) | A map of security group egress rule defintions to add to the security group created | `map(any)` | `{}` | no |
| <a name="input_security_group_tags"></a> [security\_group\_tags](#input\_security\_group\_tags) | Additional tags for the security group | `map(string)` | `{}` | no |
| <a name="input_security_group_use_name_prefix"></a> [security\_group\_use\_name\_prefix](#input\_security\_group\_use\_name\_prefix) | Determines whether the security group name (`name`) is used as a prefix | `bool` | `true` | no |
| <a name="input_serverlessv2_scaling_configuration"></a> [serverlessv2\_scaling\_configuration](#input\_serverlessv2\_scaling\_configuration) | Map of nested attributes with serverless v2 scaling properties. Only valid when `engine_mode` is set to `provisioned` | `map(string)` | `{}` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | Determines whether a final snapshot is created before the cluster is deleted. If true is specified, no snapshot is created | `bool` | `null` | no |
| <a name="input_snapshot_identifier"></a> [snapshot\_identifier](#input\_snapshot\_identifier) | Specifies whether or not to create this cluster from a snapshot. You can use either the name or ARN when specifying a DB cluster snapshot, or the ARN when specifying a DB snapshot | `string` | `null` | no |
| <a name="input_source_region"></a> [source\_region](#input\_source\_region) | The source region for an encrypted replica DB cluster | `string` | `null` | no |
| <a name="input_storage_encrypted"></a> [storage\_encrypted](#input\_storage\_encrypted) | Specifies whether the DB cluster is encrypted. The default is `true` | `bool` | `true` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | List of subnet IDs used by database subnet group created | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_vpc-db-all-subnets"></a> [vpc-db-all-subnets](#input\_vpc-db-all-subnets) | n/a | `list(string)` | `[]` | no |
| <a name="input_vpc_db_vpc_id"></a> [vpc\_db\_vpc\_id](#input\_vpc\_db\_vpc\_id) | n/a | `string` | `""` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC where to create security group | `string` | `""` | no |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | List of VPC security groups to associate to the cluster in addition to the SG we create in this module | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_Aurora-Cluster-DB1"></a> [Aurora-Cluster-DB1](#output\_Aurora-Cluster-DB1) | Detail of the DB1 cluster |
| <a name="output_Aurora-Cluster-DB2"></a> [Aurora-Cluster-DB2](#output\_Aurora-Cluster-DB2) | Detail of the DB2 cluster |
| <a name="output_DB-Password"></a> [DB-Password](#output\_DB-Password) | master user password |
| <a name="output_db1-reader-endpoint"></a> [db1-reader-endpoint](#output\_db1-reader-endpoint) | A read-only endpoint for the cluster, automatically load-balanced across replicas |
| <a name="output_db1-writer-endpoint"></a> [db1-writer-endpoint](#output\_db1-writer-endpoint) | Writer endpoint for the db1 cluster |
| <a name="output_db2-reader-endpoint"></a> [db2-reader-endpoint](#output\_db2-reader-endpoint) | A read-only endpoint for the cluster, automatically load-balanced across replicas |
| <a name="output_db2-writer-endpoint"></a> [db2-writer-endpoint](#output\_db2-writer-endpoint) | Writer endpoint for the db2 cluster |
<!-- END_TF_DOCS -->