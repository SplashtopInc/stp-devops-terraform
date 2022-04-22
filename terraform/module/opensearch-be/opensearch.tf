

# https://github.com/cloudposse/terraform-aws-elasticsearch/issues/5#issuecomment-737279024
resource "aws_iam_service_linked_role" "elasticsearch_service_linked_role" {
  count            = var.be_elasticsearch_create_role ? 1 : 0
  aws_service_name = "es.amazonaws.com"
}

resource "aws_elasticsearch_domain_policy" "be_elasticsearch_domain_policy" {
  domain_name = aws_elasticsearch_domain.be_elasticsearch_domain.domain_name

  access_policies = <<POLICIES
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "es:ESHttp*",
      "Resource": "arn:aws:es:${var.region}:${data.aws_caller_identity.current.account_id}:domain/${local.elasticache_cluster_domain}/*"
    },
    {
      "Effect": "Deny",
      "Principal": {
        "AWS": "*"
      },
      "Action": "es:ESHttp*",
      "Resource": "arn:aws:es:${var.region}:${data.aws_caller_identity.current.account_id}:domain/${local.elasticache_cluster_domain}/_dashboards*"
    }
  ]
}
POLICIES
}

resource "aws_elasticsearch_domain" "be_elasticsearch_domain" {
  #ts:skip=AWS.ElasticSearch.EKM.Medium.0768 skip
  #checkov:skip=CKV_AWS_137:The Elasticsearch is a public and limited ip address
  #ts:skip=AWS.Elasticsearch.Logging.Medium.0573 already add slow logs
  domain_name           = local.elasticache_cluster_domain
  elasticsearch_version = "OpenSearch_1.1"

  vpc_options {
    subnet_ids         = var.be_elasticsearch_multiaz ? data.aws_subnet_ids.stp_vpc_db_private.ids : toset([tolist(data.aws_subnet_ids.stp_vpc_db_private.ids)[0]])
    security_group_ids = [aws_security_group.elasticsearch_sg.id]
  }

  advanced_security_options {
    enabled = true
    master_user_options {
      master_user_arn = aws_iam_role.premium_inventory_opensearch_master_user.arn
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
    enabled                  = var.be_elasticsearch_search_logs_enabled
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.elasticsearch_log_group_search_logs.arn
    log_type                 = "SEARCH_SLOW_LOGS"
  }
  log_publishing_options {
    enabled                  = var.be_elasticsearch_index_logs_enabled
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.elasticsearch_log_group_index_logs.arn
    log_type                 = "INDEX_SLOW_LOGS"
  }
  log_publishing_options {
    enabled                  = var.be_elasticsearch_application_logs_enabled
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.elasticsearch_log_group_application_logs.arn
    log_type                 = "ES_APPLICATION_LOGS"
  }
  log_publishing_options {
    enabled                  = var.be_elasticsearch_audit_logs_enabled
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.elasticsearch_log_group_audit_logs.arn
    log_type                 = "AUDIT_LOGS"
  }

  tags = {
    Domain = local.elasticache_cluster_domain
  }

  depends_on = [
    aws_iam_service_linked_role.elasticsearch_service_linked_role,
    aws_cloudwatch_log_group.elasticsearch_log_group_search_logs,
    aws_cloudwatch_log_group.elasticsearch_log_group_index_logs,
    aws_cloudwatch_log_group.elasticsearch_log_group_application_logs,
    aws_cloudwatch_log_group.elasticsearch_log_group_audit_logs
  ]
}


resource "aws_security_group" "elasticsearch_sg" {
  #ts:skip=AC_AWS_0322 skip
  description = "Security Group - ${local.elasticache_cluster_domain}"
  name_prefix = "${local.elasticache_cluster_domain}-sg"
  vpc_id      = data.aws_vpc.stp_vpc_db.id

  # Allow internal
  ingress {
    description = "Allow access from local LAN for Elasticsearch"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [
      "10.0.0.0/8",
      "172.16.0.0/12",
      "192.168.0.0/16"
    ]
  }

  tags = {
    Name = "${local.elasticache_cluster_domain}-sg"
  }
}
