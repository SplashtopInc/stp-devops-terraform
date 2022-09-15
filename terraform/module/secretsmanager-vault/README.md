<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.23.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret_version.redis](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_secretsmanager_secret.name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_name"></a> [account\_name](#input\_account\_name) | account\_name of a specific AWS resouce ex: tperd | `string` | `""` | no |
| <a name="input_aes_128_default_key"></a> [aes\_128\_default\_key](#input\_aes\_128\_default\_key) | AES key | `string` | `"c3a272c39247c29265c2b5c2ad44c3b5"` | no |
| <a name="input_application"></a> [application](#input\_application) | application of the eks used for ex: be-app, be-cloudbuild | `string` | `"be-app"` | no |
| <a name="input_avalara_api_account"></a> [avalara\_api\_account](#input\_avalara\_api\_account) | avalara api account | `string` | `""` | no |
| <a name="input_avalara_api_password"></a> [avalara\_api\_password](#input\_avalara\_api\_password) | avalara api password | `string` | `""` | no |
| <a name="input_avalara_api_url"></a> [avalara\_api\_url](#input\_avalara\_api\_url) | avalara api url | `string` | `""` | no |
| <a name="input_aws_access_key_id"></a> [aws\_access\_key\_id](#input\_aws\_access\_key\_id) | aws access key id | `string` | `""` | no |
| <a name="input_aws_account_name"></a> [aws\_account\_name](#input\_aws\_account\_name) | aws\_account\_name of a specific AWS resouce ex: aws-tperd | `string` | `""` | no |
| <a name="input_aws_secret_key"></a> [aws\_secret\_key](#input\_aws\_secret\_key) | aws secret key | `string` | `""` | no |
| <a name="input_be_qa"></a> [be\_qa](#input\_be\_qa) | be\_qa | `string` | `"true"` | no |
| <a name="input_bitderender_api_key"></a> [bitderender\_api\_key](#input\_bitderender\_api\_key) | bitderender api key | `string` | `""` | no |
| <a name="input_bitderender_default_id"></a> [bitderender\_default\_id](#input\_bitderender\_default\_id) | bitderender default id | `string` | `""` | no |
| <a name="input_bitderender_host_name"></a> [bitderender\_host\_name](#input\_bitderender\_host\_name) | bitderender host name | `string` | `"https://cloud.gravityzone.bitdefender.com/api"` | no |
| <a name="input_cloud_build_server_account"></a> [cloud\_build\_server\_account](#input\_cloud\_build\_server\_account) | cloud\_build\_server\_account | `string` | `""` | no |
| <a name="input_cloud_build_server_domain"></a> [cloud\_build\_server\_domain](#input\_cloud\_build\_server\_domain) | cloud\_build\_server\_domain | `string` | `"domain"` | no |
| <a name="input_cloud_build_server_token"></a> [cloud\_build\_server\_token](#input\_cloud\_build\_server\_token) | cloud\_build\_server\_token | `string` | `""` | no |
| <a name="input_cloud_build_url"></a> [cloud\_build\_url](#input\_cloud\_build\_url) | cloud build url | `string` | `""` | no |
| <a name="input_connect_secret"></a> [connect\_secret](#input\_connect\_secret) | connect\_secret | `string` | `""` | no |
| <a name="input_db1_rds_endpoint"></a> [db1\_rds\_endpoint](#input\_db1\_rds\_endpoint) | db1 Endpoint | `string` | `""` | no |
| <a name="input_db1_rds_readonly_endpoint"></a> [db1\_rds\_readonly\_endpoint](#input\_db1\_rds\_readonly\_endpoint) | db1 readonly Endpoint | `string` | `""` | no |
| <a name="input_db2_rds_endpoint"></a> [db2\_rds\_endpoint](#input\_db2\_rds\_endpoint) | db2 Endpoint | `string` | `""` | no |
| <a name="input_db2_rds_readonly_endpoint"></a> [db2\_rds\_readonly\_endpoint](#input\_db2\_rds\_readonly\_endpoint) | db2 readonly Endpoint | `string` | `""` | no |
| <a name="input_db_pool"></a> [db\_pool](#input\_db\_pool) | db\_pool | `string` | `"10"` | no |
| <a name="input_devise_secret_key"></a> [devise\_secret\_key](#input\_devise\_secret\_key) | devise\_secret\_key | `string` | `""` | no |
| <a name="input_enable_shoryuken_inline_executer"></a> [enable\_shoryuken\_inline\_executer](#input\_enable\_shoryuken\_inline\_executer) | enable\_shoryuken\_inline\_executer | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment of a specific AWS resouce ex: prod, test, qa | `string` | `""` | no |
| <a name="input_global_lookup_domain"></a> [global\_lookup\_domain](#input\_global\_lookup\_domain) | global\_lookup\_domain | `string` | `""` | no |
| <a name="input_global_lookup_port"></a> [global\_lookup\_port](#input\_global\_lookup\_port) | global\_lookup\_port | `string` | `"4433"` | no |
| <a name="input_global_lookup_switch"></a> [global\_lookup\_switch](#input\_global\_lookup\_switch) | global\_lookup\_switch | `string` | `"true"` | no |
| <a name="input_global_unique_check"></a> [global\_unique\_check](#input\_global\_unique\_check) | global\_unique\_check | `string` | `"false"` | no |
| <a name="input_gongliao_jwt_secret_key"></a> [gongliao\_jwt\_secret\_key](#input\_gongliao\_jwt\_secret\_key) | gongliao\_jwt\_secret\_key | `string` | `""` | no |
| <a name="input_google_fcm"></a> [google\_fcm](#input\_google\_fcm) | google\_fcm | `string` | `""` | no |
| <a name="input_google_recaptcha_priv_key"></a> [google\_recaptcha\_priv\_key](#input\_google\_recaptcha\_priv\_key) | google\_recaptcha\_priv\_key | `string` | `""` | no |
| <a name="input_google_recaptcha_pub_key"></a> [google\_recaptcha\_pub\_key](#input\_google\_recaptcha\_pub\_key) | google\_recaptcha\_pub\_key | `string` | `""` | no |
| <a name="input_log_rds_database"></a> [log\_rds\_database](#input\_log\_rds\_database) | log\_rds\_database | `string` | `""` | no |
| <a name="input_log_rds_password"></a> [log\_rds\_password](#input\_log\_rds\_password) | log\_rds\_password | `string` | `""` | no |
| <a name="input_log_rds_user"></a> [log\_rds\_user](#input\_log\_rds\_user) | log\_rds\_password | `string` | `""` | no |
| <a name="input_master_redis_address"></a> [master\_redis\_address](#input\_master\_redis\_address) | master endpoint address of elasticache | `string` | `""` | no |
| <a name="input_next_public_sentry_dsn"></a> [next\_public\_sentry\_dsn](#input\_next\_public\_sentry\_dsn) | next\_public\_sentry\_dsn | `string` | `""` | no |
| <a name="input_next_public_sentry_host"></a> [next\_public\_sentry\_host](#input\_next\_public\_sentry\_host) | next\_public\_sentry\_host | `string` | `""` | no |
| <a name="input_next_public_sentry_hostname"></a> [next\_public\_sentry\_hostname](#input\_next\_public\_sentry\_hostname) | next\_public\_sentry\_hostname | `string` | `""` | no |
| <a name="input_noaof_redis_address"></a> [noaof\_redis\_address](#input\_noaof\_redis\_address) | noaof endpoint address of elasticache | `string` | `""` | no |
| <a name="input_opensearch_endpoint"></a> [opensearch\_endpoint](#input\_opensearch\_endpoint) | opensearch Endpoint | `string` | `""` | no |
| <a name="input_project"></a> [project](#input\_project) | Project of a specific AWS resouce ex: BE | `string` | `""` | no |
| <a name="input_rails_env"></a> [rails\_env](#input\_rails\_env) | ENV for rails | `string` | `"production"` | no |
| <a name="input_rails_secret_token"></a> [rails\_secret\_token](#input\_rails\_secret\_token) | token for rails | `string` | `""` | no |
| <a name="input_rds_database"></a> [rds\_database](#input\_rds\_database) | rds\_database | `string` | `""` | no |
| <a name="input_rds_password"></a> [rds\_password](#input\_rds\_password) | rds\_password | `string` | `""` | no |
| <a name="input_rds_readonly_database"></a> [rds\_readonly\_database](#input\_rds\_readonly\_database) | rds\_readonly\_database | `string` | `""` | no |
| <a name="input_rds_readonly_password"></a> [rds\_readonly\_password](#input\_rds\_readonly\_password) | rds\_readonly\_password | `string` | `""` | no |
| <a name="input_rds_readonly_user"></a> [rds\_readonly\_user](#input\_rds\_readonly\_user) | rds\_readonly\_user | `string` | `""` | no |
| <a name="input_rds_user"></a> [rds\_user](#input\_rds\_user) | rds\_user | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | provides details about a specific AWS region ex:ap-northeast-3 | `string` | `""` | no |
| <a name="input_sale_force_insrance_url"></a> [sale\_force\_insrance\_url](#input\_sale\_force\_insrance\_url) | sale\_force\_insrance\_url | `string` | `""` | no |
| <a name="input_sale_force_username"></a> [sale\_force\_username](#input\_sale\_force\_username) | sale\_force\_username | `string` | `""` | no |
| <a name="input_secretsmanager_secret_name"></a> [secretsmanager\_secret\_name](#input\_secretsmanager\_secret\_name) | Secrets manager secret name | `string` | `""` | no |
| <a name="input_sentry_org"></a> [sentry\_org](#input\_sentry\_org) | sentry\_org | `string` | `""` | no |
| <a name="input_sentry_project"></a> [sentry\_project](#input\_sentry\_project) | sentry\_project | `string` | `""` | no |
| <a name="input_server_region"></a> [server\_region](#input\_server\_region) | server\_region | `string` | `""` | no |
| <a name="input_short_region"></a> [short\_region](#input\_short\_region) | provides short name of a specific AWS region ex: apn3 | `string` | `""` | no |
| <a name="input_splashtop_vault_client_certificate"></a> [splashtop\_vault\_client\_certificate](#input\_splashtop\_vault\_client\_certificate) | splashtop vault certificate | `string` | `""` | no |
| <a name="input_splashtop_vault_client_private_key"></a> [splashtop\_vault\_client\_private\_key](#input\_splashtop\_vault\_client\_private\_key) | splashtop vault private key | `string` | `""` | no |
| <a name="input_src_command"></a> [src\_command](#input\_src\_command) | src\_command of SQS | `string` | `""` | no |
| <a name="input_timeout_redis_address"></a> [timeout\_redis\_address](#input\_timeout\_redis\_address) | timeout endpoint address of elasticache | `string` | `""` | no |
| <a name="input_webpack_local_server"></a> [webpack\_local\_server](#input\_webpack\_local\_server) | webpack\_local\_server of SQS | `string` | `"false"` | no |
| <a name="input_websocket_redis_address"></a> [websocket\_redis\_address](#input\_websocket\_redis\_address) | websocket endpoint address of elasticache | `string` | `""` | no |
| <a name="input_zendesk_sta_url"></a> [zendesk\_sta\_url](#input\_zendesk\_sta\_url) | zendesk\_sta\_url | `string` | `""` | no |
| <a name="input_zendesk_stb_url"></a> [zendesk\_stb\_url](#input\_zendesk\_stb\_url) | zendesk\_stb\_url | `string` | `""` | no |
| <a name="input_zendesk_stp_url"></a> [zendesk\_stp\_url](#input\_zendesk\_stp\_url) | zendesk\_stp\_url | `string` | `""` | no |
| <a name="input_zuora_rest_api"></a> [zuora\_rest\_api](#input\_zuora\_rest\_api) | zuora\_rest\_api | `string` | `""` | no |
| <a name="input_zuora_rest_sandbox_api"></a> [zuora\_rest\_sandbox\_api](#input\_zuora\_rest\_sandbox\_api) | zuora\_rest\_sandbox\_api | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secretsmanager_json"></a> [secretsmanager\_json](#output\_secretsmanager\_json) | n/a |
<!-- END_TF_DOCS -->