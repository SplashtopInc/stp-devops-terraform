########################
### Site information ###
########################
variable "region" {
  type        = string
  default     = ""
  description = "provides details about a specific AWS region ex:ap-northeast-3"
}

variable "short_region" {
  type        = string
  default     = ""
  description = "provides short name of a specific AWS region ex: apn3"
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment of a specific AWS resouce ex: prod, test, qa"
}

variable "project" {
  type        = string
  default     = ""
  description = "Project of a specific AWS resouce ex: BE"
}

variable "account_name" {
  type        = string
  default     = ""
  description = "account_name of a specific AWS resouce ex: tperd"
}

variable "aws_account_name" {
  type        = string
  default     = ""
  description = "aws_account_name of a specific AWS resouce ex: aws-tperd"
}

variable "application" {
  type        = string
  default     = "be-app"
  description = "application of the eks used for ex: be-app, be-cloudbuild"
}
############################
### secrets manager name ###
############################

variable "secretsmanager_secret_name" {
  type        = string
  default     = ""
  description = "Secrets manager secret name"
}

########################
### AES ###
########################

variable "aes_128_default_key" {
  type        = string
  default     = "c3a272c39247c29265c2b5c2ad44c3b5"
  description = "AES key"
}

########################
### AVALARA ###
########################

variable "avalara_api_account" {
  type        = string
  default     = ""
  description = "avalara api account"
}

variable "avalara_api_password" {
  type        = string
  default     = ""
  description = "avalara api password"
}

variable "avalara_api_url" {
  type        = string
  default     = ""
  description = "avalara api url"
}

########################
### AWS ###
########################

variable "aws_access_key_id" {
  type        = string
  default     = ""
  description = "aws access key id"
}

variable "aws_secret_key" {
  type        = string
  default     = ""
  description = "aws secret key"
}

variable "cloud_build_url" {
  type        = string
  default     = ""
  description = "cloud build url"
}

variable "be_qa" {
  type        = string
  default     = "true"
  description = "be_qa"
}

########################
### BITDEFENDER ###
########################

variable "bitderender_api_key" {
  type        = string
  default     = ""
  description = "bitderender api key"
}

variable "bitderender_default_id" {
  type        = string
  default     = ""
  description = "bitderender default id"
}

variable "bitderender_host_name" {
  type        = string
  default     = "https://cloud.gravityzone.bitdefender.com/api"
  description = "bitderender host name"
}

########################
### CLOUD_BUILD_SERVER #
########################

variable "cloud_build_server_account" {
  type        = string
  default     = ""
  description = "cloud_build_server_account"
}

variable "cloud_build_server_token" {
  type        = string
  default     = ""
  description = "cloud_build_server_token"
}

variable "cloud_build_server_domain" {
  type        = string
  default     = "domain"
  description = "cloud_build_server_domain"
}

variable "connect_secret" {
  type        = string
  default     = ""
  description = "connect_secret"
}

variable "db_pool" {
  type        = string
  default     = "10"
  description = "db_pool"
}

variable "devise_secret_key" {
  type        = string
  default     = ""
  description = "devise_secret_key"
}

variable "enable_shoryuken_inline_executer" {
  type        = string
  default     = ""
  description = "enable_shoryuken_inline_executer"
}

########################
### GLOBAL_LOOKUP ###
########################

variable "global_lookup_domain" {
  type        = string
  default     = ""
  description = "global_lookup_domain"
}

variable "global_lookup_port" {
  type        = string
  default     = "4433"
  description = "global_lookup_port"
}

variable "global_lookup_switch" {
  type        = string
  default     = "true"
  description = "global_lookup_switch"
}

variable "global_unique_check" {
  type        = string
  default     = "false"
  description = "global_unique_check"
}

variable "gongliao_jwt_secret_key" {
  type        = string
  default     = ""
  description = "gongliao_jwt_secret_key"
}

########################
### GOOGLE ###
########################

variable "google_fcm" {
  type        = string
  default     = ""
  description = "google_fcm"
}

variable "google_recaptcha_priv_key" {
  type        = string
  default     = ""
  description = "google_recaptcha_priv_key"
}

variable "google_recaptcha_pub_key" {
  type        = string
  default     = ""
  description = "google_recaptcha_pub_key"
}

########################
### LOG_RDS ###
########################

variable "log_rds_database" {
  type        = string
  default     = ""
  description = "log_rds_database"
}

variable "log_rds_password" {
  type        = string
  default     = ""
  description = "log_rds_password"
}

variable "log_rds_user" {
  type        = string
  default     = ""
  description = "log_rds_password"
}

########################
### NEXT_PUBLIC_SENTRY ###
########################

variable "next_public_sentry_dsn" {
  type        = string
  default     = ""
  description = "next_public_sentry_dsn"
}

variable "next_public_sentry_host" {
  type        = string
  default     = ""
  description = "next_public_sentry_host"
}

variable "next_public_sentry_hostname" {
  type        = string
  default     = ""
  description = "next_public_sentry_hostname"
}

########################
### opensearch ###
########################

variable "opensearch_endpoint" {
  type        = string
  default     = ""
  description = "opensearch Endpoint"
}

########################
### RAILS ###
########################

variable "rails_env" {
  type        = string
  default     = "production"
  description = "ENV for rails"
}

variable "rails_secret_token" {
  type        = string
  default     = ""
  description = "token for rails"
}

########################
### RDS ###
########################

variable "db1_rds_endpoint" {
  type        = string
  default     = ""
  description = "db1 Endpoint"
}

variable "db1_rds_readonly_endpoint" {
  type        = string
  default     = ""
  description = "db1 readonly Endpoint"
}

variable "db2_rds_endpoint" {
  type        = string
  default     = ""
  description = "db2 Endpoint"
}

variable "db2_rds_readonly_endpoint" {
  type        = string
  default     = ""
  description = "db2 readonly Endpoint"
}
#
variable "rds_database" {
  type        = string
  default     = ""
  description = "rds_database"
}

variable "rds_password" {
  type        = string
  default     = ""
  description = "rds_password"
}

variable "rds_user" {
  type        = string
  default     = ""
  description = "rds_user"
}
#
variable "rds_readonly_database" {
  type        = string
  default     = ""
  description = "rds_readonly_database"
}

variable "rds_readonly_password" {
  type        = string
  default     = ""
  description = "rds_readonly_password"
}

variable "rds_readonly_user" {
  type        = string
  default     = ""
  description = "rds_readonly_user"
}

########################
### REDIS ###
########################

variable "master_redis_address" {
  type        = string
  default     = ""
  description = "master endpoint address of elasticache"
}

variable "noaof_redis_address" {
  type        = string
  default     = ""
  description = "noaof endpoint address of elasticache"
}

variable "timeout_redis_address" {
  type        = string
  default     = ""
  description = "timeout endpoint address of elasticache"
}

variable "websocket_redis_address" {
  type        = string
  default     = ""
  description = "websocket endpoint address of elasticache"
}

########################
### SALE_FORCE ###
########################

variable "sale_force_insrance_url" {
  type        = string
  default     = ""
  description = "sale_force_insrance_url"
}

variable "sale_force_username" {
  type        = string
  default     = ""
  description = "sale_force_username"
}

########################
### SENTRY ###
########################

variable "sentry_org" {
  type        = string
  default     = ""
  description = "sentry_org"
}

variable "sentry_project" {
  type        = string
  default     = ""
  description = "sentry_project"
}

variable "server_region" {
  type        = string
  default     = ""
  description = "server_region"
}

########################
### SQS ###
########################

variable "src_command" {
  type        = string
  default     = ""
  description = "src_command of SQS"
}

variable "webpack_local_server" {
  type        = string
  default     = "false"
  description = "webpack_local_server of SQS"
}

########################
### ZENDESK ###
########################

variable "zendesk_sta_url" {
  type        = string
  default     = ""
  description = "zendesk_sta_url"
}

variable "zendesk_stb_url" {
  type        = string
  default     = ""
  description = "zendesk_stb_url"
}

variable "zendesk_stp_url" {
  type        = string
  default     = ""
  description = "zendesk_stp_url"
}

########################
### splashtop vault  ###
########################

variable "splashtop_vault_client_certificate" {
  type        = string
  default     = ""
  description = "splashtop vault certificate"
}

variable "splashtop_vault_client_private_key" {
  type        = string
  default     = ""
  description = "splashtop vault private key"
}

########################
### ZUORA  ###
########################

variable "zuora_rest_api" {
  type        = string
  default     = ""
  description = "zuora_rest_api"
}

variable "zuora_rest_sandbox_api" {
  type        = string
  default     = ""
  description = "zuora_rest_sandbox_api"
}