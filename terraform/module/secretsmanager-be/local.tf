locals {
  secretsmanager_json = {
    "AES_128_DEFAULT_KEY" = "${var.aes_128_default_key}",
    #AVALARA
    "AVALARA_API_ACCOUNT"  = "${var.avalara_api_account}",
    "AVALARA_API_PASSWORD" = "${var.avalara_api_password}",
    "AVALARA_API_URL"      = "${var.avalara_api_url}",
    #AWS
    "AWS_ACCESS_KEY_ID"                   = "${var.aws_access_key_id}",
    "AWS_SECRET_ACCESS_KEY"               = "${var.aws_secret_key}",
    "AWS_CLOUD_FRONT_FOR_CLOUD_BUILD_URL" = "${var.cloud_build_url}",
    "AWS_REGION"                          = "${var.region}",
    #AWS_S3
    "AWS_S3_FOR_CLOUD_BUILD_BUCKECT_ID"             = "splashtop-${var.project}-${var.environment}-${var.short_region}-cloudbuild",
    "AWS_S3_FOR_COMMAND_PROMPT_SESSIONS_BUCKECT_ID" = "splashtop-${var.project}-${var.environment}-${var.short_region}-command-prompt-sessions",
    "AWS_S3_FOR_CUSTOMIZED_THEME_BUCKECT_ID"        = "splashtop-${var.project}-${var.environment}-${var.short_region}-customized-theme",
    "AWS_S3_FOR_EVENT_LOG_BUCKECT_ID"               = "splashtop-${var.project}-${var.environment}-${var.short_region}-event-log",
    "AWS_S3_FOR_INVENTORY_BUCKECT_ID"               = "splashtop-${var.project}-${var.environment}-${var.short_region}-inventory",
    "AWS_S3_FOR_INVENTORY_REGION"                   = "${var.region}",
    "AWS_S3_FOR_LATEST_INVENTORY_BUCKECT_ID"        = "splashtop-${var.project}-${var.environment}-${var.short_region}-inventory-latest",
    "AWS_S3_FOR_ONE_TO_MANY_BUCKECT_ID"             = "splashtop-${var.project}-${var.environment}-${var.short_region}-1-to-many",
    "AWS_SQS_PREFIX"                                = "aws-${var.account_name}-",
    "BE_QA"                                         = "${var.be_qa}",
    #BITDEFENDER
    "BITDEFENDER_API_KEY"    = "${var.bitderender_api_key}",
    "BITDEFENDER_DEFAULT_ID" = "${var.bitderender_default_id}",
    "BITDEFENDER_HOST_NAME"  = "${var.bitderender_host_name}",
    #CLOUD_BUILD_SERVER
    "CLOUD_BUILD_SERVER_ACCOUNT"       = "${var.cloud_build_server_account}",
    "CLOUD_BUILD_SERVER_TOKEN"         = "${var.cloud_build_server_token}",
    "CLOUD_BUILD_SERVER_URL"           = "http://${var.account_name}-cloudbuilder.internal.${var.account_name}.${var.cloud_build_server_domain}:8080/job/CreateBuild_CSRS/build",
    "CONNECT_SECRET"                   = "${var.connect_secret}",
    "DB_POOL"                          = "${var.db_pool}",
    "DEFAULT_API_GATEWAY"              = "wss://srcgw-${var.environment}.api.${var.aws_account_name}.${var.cloud_build_server_domain}/be-dev",
    "DEPLOY_DOMAIN"                    = "${var.account_name}.${var.cloud_build_server_domain}",
    "DEVISE_SECRET_KEY"                = "${var.devise_secret_key}",
    "ENABLE_SHORYUKEN_INLINE_EXECUTER" = "${var.enable_shoryuken_inline_executer}",
    #GLOBAL_LOOKUP
    "GLOBAL_LOOKUP_FQDN"      = "https://st-lookup.api.${var.aws_account_name}.${var.global_lookup_domain}/",
    "GLOBAL_LOOKUP_PORT"      = "${var.global_lookup_port}",
    "GLOBAL_LOOKUP_SWITCH"    = "${var.global_lookup_switch}",
    "GLOBAL_UNIQUE_CHECK"     = "${var.global_unique_check}",
    "GONGLIAO_JWT_SECRET_KEY" = "${var.gongliao_jwt_secret_key}",
    #google
    "GOOGLE_FCM"                = "${var.google_fcm}",
    "GOOGLE_RECAPTCHA_PRIV_KEY" = "${var.google_recaptcha_priv_key}",
    "GOOGLE_RECAPTCHA_PUB_KEY"  = "${var.google_recaptcha_pub_key}",
    #LOG_RDS
    "LOG_RDS_DATABASE"      = "${var.log_rds_database}",
    #"LOG_RDS_HOST"          = "${local.db2_writer_endpoint}",
    "LOG_RDS_HOST"          = "${local.db2_writer_endpoint == "null" ? local.db1_writer_endpoint : local.db2_writer_endpoint}",
    "LOG_RDS_PASSWORD"      = "${var.log_rds_password}",
    "LOG_RDS_USER"          = "${var.log_rds_user}",
    #"LOG_READONLY_RDS_HOST" = "${local.db2_reader_endpoint}",
    "LOG_READONLY_RDS_HOST" = "${local.db2_reader_endpoint == "null" ? local.db1_reader_endpoint : local.db2_reader_endpoint}",
    #MS_TEAMS
    "MS_TEAMS_APP_ID"       = "",
    "MS_TEAMS_BOT_ID"       = "",
    "MS_TEAMS_BOT_PASSWORD" = "",
    #NEXT_PUBLIC_SENTRY
    "NEXT_PUBLIC_SENTRY_DSN"      = "${var.next_public_sentry_dsn}",
    "NEXT_PUBLIC_SERVER_HOST"     = "${var.next_public_sentry_host}",
    "NEXT_PUBLIC_SERVER_HOSTNAME" = "${var.next_public_sentry_hostname}",
    #OPENSEARCH
    "OPENSEARCH_URL" = "${local.opensearch_endpoint}",
    #PAYPAL
    "PAYPAL_BIZ_ID" = "",
    "PAYPAL_HOST"   = "https://www.sandbox.paypal.com",
    "PENDO_KEY"     = "",
    #RAILS
    "RAILS_ENV"          = "${var.rails_env}",
    "RAILS_SECRET_TOKEN" = "${var.rails_secret_token}",
    #RDS_ANALYSIS
    "RDS_ANALYSIS_DB2_HOST" = "${local.db2_reader_endpoint}",
    "RDS_ANALYSIS_HOST"     = "${local.db2_reader_endpoint}",
    #RDS
    "RDS_DATABASE"    = "${var.rds_database}",
    "RDS_HOST"        = "${local.db1_writer_endpoint}",
    "RDS_PASSWORD"    = "${var.rds_password}",
    "RDS_USER"        = "${var.rds_user}",
    "RDS_OREGON_HOST" = "${local.db1_reader_endpoint}",
    #RDS_READONLY
    "RDS_READONLY_DATABASE" = "${var.rds_readonly_database}",
    "RDS_READONLY_HOST"     = "${local.db1_reader_endpoint}",
    "RDS_READONLY_PASSWORD" = "${var.rds_readonly_password}",
    "RDS_READONLY_USER"     = "${var.rds_readonly_user}",
    "RDS_SSL_CA"            = "config/rds-combined-ca-bundle.pem",
    #reCAPTCHA
    "RECAPTCHA_SECRET_KEY" = "",
    "RECAPTCHA_SITE_KEY"   = "",
    #REDIS
    "REDIS_MASTER_URL"     = "${local.REDIS_MASTER_URL}",
    "REDIS_NOAOF_URL"      = "${local.REDIS_NOAOF_URL}",
    "REDIS_TIMEOUT_URL"    = "${local.REDIS_TIMEOUT_URL}",
    "REDIS_WEBSOCKET_URL"  = "${local.REDIS_WEBSOCKET_URL}",
    "ROLLBAR_ACCESS_TOKEN" = "",
    #SALE_FORCE
    "SALE_FORCE_CLIENT_ID"     = "",
    "SALE_FORCE_CLIENT_SECRET" = "",
    "SALE_FORCE_INSTANCE_URL"  = "${var.sale_force_insrance_url}",
    "SALE_FORCE_REFRESH_TOKEN" = "",
    "SALE_FORCE_TOKEN"         = "",
    "SALE_FORCE_USERNAME"      = "${var.sale_force_username}",
    #SENTRY
    "BUILD_WITH_SENTRY" = "true",
    "SENTRY_AUTH_TOKEN" = "",
    "SENTRY_ORG"        = "${var.sentry_org}",
    "SENTRY_PROJECT"    = "${var.sentry_project}",
    "SENTRY_TOKEN"      = "",
    "SENTRY_URL"        = "",
    "SERVER_REGION"     = "${var.server_region}",
    #SES_SMTP
    "SES_SMTP_ADDRESS"  = "",
    "SES_SMTP_PASSWORD" = "",
    "SES_SMTP_USERNAME" = "",
    #SQS
    "SQS_SRC_COMMAND"      = "${local.src_command}",
    "TRIAL_API_SHARED_KEY" = "",
    "WEBPACK_LOCAL_SERVER" = "${var.webpack_local_server}",
    #ZENDESK
    "ZENDESK_STA_TOKEN" = "",
    "ZENDESK_STA_URL"   = "${var.zendesk_sta_url}",
    "ZENDESK_STB_TOKEN" = "",
    "ZENDESK_STB_URL"   = "${var.zendesk_stb_url}",
    "ZENDESK_STP_TOKEN" = "",
    "ZENDESK_STP_URL"   = "${var.zendesk_stp_url}",
    #ZUORA
    "ZUORA_AIRCASTING_HOTS_PAGE_ID"   = "",
    "ZUORA_API_PASSWORD"              = "",
    "ZUORA_API_SEC_KEY"               = "",
    "ZUORA_API_USER_NAME"             = "",
    "ZUORA_API_VERSION"               = "257.0",
    "ZUORA_BANK_SEPA_HOTS_PAGE_ID"    = "",
    "ZUORA_CLASSROOM_HOTS_PAGE_ID"    = "",
    "ZUORA_HOTS_PAGE_ID"              = "",
    "ZUORA_M360_PAYMENT_HOTS_PAGE_ID" = "",
    "ZUORA_PAYPAL2_API_PASSWORD"      = "",
    "ZUORA_PAYPAL2_API_SIGNATURE"     = "",
    "ZUORA_PAYPAL2_API_USER_NAME"     = "",
    "ZUORA_PAYPAL_API_PASSWORD"       = "",
    "ZUORA_PAYPAL_API_SIGNATURE"      = "",
    "ZUORA_PAYPAL_API_USER_NAME"      = "",
    "ZUORA_REST_API"                  = "${var.zuora_rest_api}",
    "ZUORA_REST_SANDBOX_API"          = "${var.zuora_rest_sandbox_api}",
    #Splashtop vault
    "VAULT_CLIENT_CERTIFICATE" = "${var.splashtop_vault_client_certificate}",
    "VAULT_CLIENT_PRIVATE_KEY" = "${var.splashtop_vault_client_private_key}"
  }
}