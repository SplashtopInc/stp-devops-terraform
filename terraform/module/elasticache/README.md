<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_elasticache_parameter_group.redis-para-group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_parameter_group) | resource |
| [aws_elasticache_replication_group.redis-replica-group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group) | resource |
| [aws_elasticache_subnet_group.redis-subnet-group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group) | resource |
| [aws_security_group.redis-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [random_password.redis_auth_token](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_subnets.stp-vpc-db-private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.stp-vpc-db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assume_role"></a> [assume\_role](#input\_assume\_role) | n/a | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `""` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | AWS privilege | `string` | `""` | no |
| <a name="input_project"></a> [project](#input\_project) | n/a | `string` | `""` | no |
| <a name="input_redis-sg-cidr"></a> [redis-sg-cidr](#input\_redis-sg-cidr) | n/a | `list(string)` | <pre>[<br>  "10.0.0.0/8",<br>  "172.16.0.0/12",<br>  "192.168.0.0/16"<br>]</pre> | no |
| <a name="input_redis_engine_ver"></a> [redis\_engine\_ver](#input\_redis\_engine\_ver) | n/a | `string` | `"6.x"` | no |
| <a name="input_redis_failover"></a> [redis\_failover](#input\_redis\_failover) | n/a | `bool` | `true` | no |
| <a name="input_redis_maintenance_window"></a> [redis\_maintenance\_window](#input\_redis\_maintenance\_window) | Maintenance window to each Redis nodes | `list(string)` | <pre>[<br>  "mon:01:00-mon:02:00",<br>  "tue:01:00-tue:02:00",<br>  "wed:02:00-wed:03:00",<br>  "thu:03:00-thu:04:00"<br>]</pre> | no |
| <a name="input_redis_multiaz"></a> [redis\_multiaz](#input\_redis\_multiaz) | n/a | `bool` | `true` | no |
| <a name="input_redis_node_type"></a> [redis\_node\_type](#input\_redis\_node\_type) | n/a | `string` | `"cache.t3.medium"` | no |
| <a name="input_redis_nodes_list"></a> [redis\_nodes\_list](#input\_redis\_nodes\_list) | Redis nodes list | `list(string)` | <pre>[<br>  "redis-master",<br>  "redis-noaof",<br>  "redis-timeout",<br>  "redis-websocket"<br>]</pre> | no |
| <a name="input_redis_num_cache_nodes"></a> [redis\_num\_cache\_nodes](#input\_redis\_num\_cache\_nodes) | n/a | `number` | `2` | no |
| <a name="input_redis_para_notify_keyspace_events_list"></a> [redis\_para\_notify\_keyspace\_events\_list](#input\_redis\_para\_notify\_keyspace\_events\_list) | Parameter Group - notify-keyspace-events | `list(string)` | <pre>[<br>  "",<br>  "",<br>  "xE",<br>  ""<br>]</pre> | no |
| <a name="input_redis_para_timeout_list"></a> [redis\_para\_timeout\_list](#input\_redis\_para\_timeout\_list) | Parameter Group - timeout | `list(string)` | <pre>[<br>  "600",<br>  "600",<br>  "600",<br>  "600"<br>]</pre> | no |
| <a name="input_redis_parameter_group_family"></a> [redis\_parameter\_group\_family](#input\_redis\_parameter\_group\_family) | n/a | `string` | `"redis6.x"` | no |
| <a name="input_redis_snapshot_retention_limit"></a> [redis\_snapshot\_retention\_limit](#input\_redis\_snapshot\_retention\_limit) | n/a | `number` | `1` | no |
| <a name="input_redis_snapshot_window"></a> [redis\_snapshot\_window](#input\_redis\_snapshot\_window) | Snapshot window to each Redis nodes | `list(string)` | <pre>[<br>  "00:00-01:00",<br>  "23:00-00:00",<br>  "01:00-02:00",<br>  "02:00-03:00"<br>]</pre> | no |
| <a name="input_redis_sns_arn"></a> [redis\_sns\_arn](#input\_redis\_sns\_arn) | n/a | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `""` | no |
| <a name="input_vpc-db-private-subnets"></a> [vpc-db-private-subnets](#input\_vpc-db-private-subnets) | vpc module outputs the db-private-subnet ID under the name subnets | `list(string)` | `[]` | no |
| <a name="input_vpc_db_vpc_id"></a> [vpc\_db\_vpc\_id](#input\_vpc\_db\_vpc\_id) | vpc module outputs the ID under the name vpc\_id | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_Redis_AuthToken"></a> [Redis\_AuthToken](#output\_Redis\_AuthToken) | n/a |
| <a name="output_Redis_Nodes"></a> [Redis\_Nodes](#output\_Redis\_Nodes) | n/a |
| <a name="output_master_redis_address"></a> [master\_redis\_address](#output\_master\_redis\_address) | n/a |
| <a name="output_noaof_redis_address"></a> [noaof\_redis\_address](#output\_noaof\_redis\_address) | n/a |
| <a name="output_timeout_redis_address"></a> [timeout\_redis\_address](#output\_timeout\_redis\_address) | n/a |
| <a name="output_websocket_redis_address"></a> [websocket\_redis\_address](#output\_websocket\_redis\_address) | n/a |
<!-- END_TF_DOCS -->