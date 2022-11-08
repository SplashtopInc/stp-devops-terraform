resource "random_password" "be_elasticsearch_master_user_password" {
  count            = (var.enabled && var.be_elasticsearch_is_production) ? 1 : 0
  length           = 32
  lower            = true
  upper            = true
  numeric          = true
  special          = true
  override_special = "!&#$^<>-"
}

# https://github.com/cloudposse/terraform-aws-elasticsearch/issues/5#issuecomment-737279024
resource "aws_iam_service_linked_role" "elasticsearch_service_linked_role" {
  count            = (var.enabled && var.be_elasticsearch_create_role) ? 1 : 0
  aws_service_name = "es.amazonaws.com"
}

resource "aws_elasticsearch_domain_policy" "be_elasticsearch_domain_policy" {
  count       = var.enabled ? 1 : 0
  domain_name = aws_elasticsearch_domain.be_elasticsearch_domain[0].domain_name

  access_policies = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : "*"
          },
          "Action" : "es:ESHttp*",
          "Resource" : "arn:aws:es:${var.region}:${data.aws_caller_identity.current.account_id}:domain/${local.elasticsearch_cluster_domain}/*"
        },
        {
          "Effect" : "Deny",
          "Principal" : {
            "AWS" : "*"
          },
          "Action" : "es:ESHttp*",
          "Resource" : "arn:aws:es:${var.region}:${data.aws_caller_identity.current.account_id}:domain/${local.elasticsearch_cluster_domain}/_dashboards*"
        }
      ]
    }
  )
}

resource "aws_elasticsearch_domain" "be_elasticsearch_domain" {
  #checkov:skip=CKV_AWS_247:
  #ts:skip=AWS.ElasticSearch.EKM.Medium.0768 skip
  #ts:skip=AWS.Elasticsearch.Logging.Medium.0573 skip
  #ts:skip=AC_AWS_0322 skip
  count                 = var.enabled ? 1 : 0
  domain_name           = local.elasticsearch_cluster_domain
  elasticsearch_version = var.be_elasticsearch_version

  vpc_options {
    subnet_ids         = var.be_elasticsearch_multiaz ? data.aws_subnets.stp_vpc_db_private.ids : toset([tolist(data.aws_subnets.stp_vpc_db_private.ids)[0]])
    security_group_ids = [aws_security_group.elasticsearch_sg[0].id]
  }

  advanced_security_options {
    enabled                        = true
    internal_user_database_enabled = true
    master_user_options {
      master_user_name     = var.be_elasticsearch_master_user_name
      master_user_password = var.be_elasticsearch_is_production ? random_password.be_elasticsearch_master_user_password[0].result : var.be_elasticsearch_nonprod_master_user_password
    }
  }

  cluster_config {
    instance_count = var.be_elasticsearch_instance_count
    instance_type  = var.be_elasticsearch_instance_type

    dedicated_master_enabled = var.be_elasticsearch_dedicated_master_enalbed
    dedicated_master_count   = var.be_elasticsearch_dedicated_master_count
    dedicated_master_type    = var.be_elasticsearch_dedicated_master_type

    zone_awareness_enabled = var.be_elasticsearch_multiaz
    #zone_awareness_config {
    #  availability_zone_count = var.be_elasticsearch_az_count
    #}
  }

  domain_endpoint_options {
    enforce_https       = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }

  ebs_options {
    ebs_enabled = true
    volume_type = "gp2"
    volume_size = var.be_elasticsearch_volume_size
  }

  encrypt_at_rest {
    enabled = true
  }

  node_to_node_encryption {
    enabled = true
  }

  log_publishing_options {
    enabled                  = true
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.elasticsearch_log_group_search_logs[0].arn
    log_type                 = "SEARCH_SLOW_LOGS"
  }
  log_publishing_options {
    enabled                  = true
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.elasticsearch_log_group_index_logs[0].arn
    log_type                 = "INDEX_SLOW_LOGS"
  }
  log_publishing_options {
    enabled                  = true
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.elasticsearch_log_group_application_logs[0].arn
    log_type                 = "ES_APPLICATION_LOGS"
  }
  log_publishing_options {
    enabled                  = true
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.elasticsearch_log_group_audit_logs[0].arn
    log_type                 = "AUDIT_LOGS"
  }

  tags = {
    Domain = local.elasticsearch_cluster_domain
  }

  depends_on = [
    aws_iam_service_linked_role.elasticsearch_service_linked_role,
    aws_cloudwatch_log_group.elasticsearch_log_group_search_logs,
    aws_cloudwatch_log_group.elasticsearch_log_group_index_logs,
    aws_cloudwatch_log_group.elasticsearch_log_group_application_logs,
    aws_cloudwatch_log_group.elasticsearch_log_group_audit_logs
  ]
}

################################################################################
# Secret Manager Module
################################################################################

locals {
  secretsmanager_name        = var.enabled ? "${var.environment}/data/opensearch/${local.elasticsearch_cluster_domain}" : ""
  secretsmanager_description = "Vault secrets for ${local.elasticsearch_cluster_domain} opensearch"
  opensearch_password        = var.be_elasticsearch_is_production ? random_password.be_elasticsearch_master_user_password[0].result : var.be_elasticsearch_nonprod_master_user_password
  opensearch_endpoint        = var.enabled ? "https://${aws_elasticsearch_domain.be_elasticsearch_domain[0].endpoint}:443" : ""
  secretsmanager_json = {
    "opensearch_endpoint" = "${local.opensearch_endpoint}",
    "opensearch_password" = "${local.opensearch_password}"
  }
}

#tfsec:ignore:aws-ssm-secret-use-customer-key
resource "aws_secretsmanager_secret" "this" {
  #checkov:skip=CKV_AWS_149: not use KMS key
  #ts:skip=AWS.AKK.DP.HIGH.0012 skip
  #ts:skip=AWS.SecretsManagerSecret.DP.MEDIUM.0036 skip
  count                   = var.enabled ? 1 : 0
  name                    = local.secretsmanager_name
  description             = local.secretsmanager_description
  recovery_window_in_days = 7
}

resource "aws_secretsmanager_secret_version" "this" {
  count         = var.enabled ? 1 : 0
  secret_id     = resource.aws_secretsmanager_secret.this[0].id
  secret_string = jsonencode(local.secretsmanager_json)
}