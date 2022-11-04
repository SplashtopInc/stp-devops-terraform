### output to eks created secret manager

data "aws_secretsmanager_secrets" "name" {
  filter {
    name   = "name"
    values = [var.secretsmanager_secret_name]
  }
}

### get secret from sqs secret manager
data "aws_secretsmanager_secrets" "sqs" {
  filter {
    name   = "name"
    values = [var.sqs_secretsmanager_name]
  }
}

data "aws_secretsmanager_secret_version" "sqs" {
  secret_id = data.aws_secretsmanager_secrets.sqs.id
}

locals {
  src_command = jsondecode(data.aws_secretsmanager_secret_version.sqs.secret_string)["src-command"]
}

#########################################
### get secret from opensearch secret manager
data "aws_secretsmanager_secrets" "opensearch" {
  filter {
    name   = "name"
    values = [var.opensearch_secretsmanager_name]
  }
}

data "aws_secretsmanager_secret_version" "opensearch" {
  secret_id = data.aws_secretsmanager_secrets.opensearch.id
}

locals {
  opensearch_endpoint = jsondecode(data.aws_secretsmanager_secret_version.opensearch.secret_string)["opensearch_endpoint"]
}

#########################################
### get secret from elasticache secret manager
data "aws_secretsmanager_secrets" "elasticache" {
  filter {
    name   = "name"
    values = [var.elasticache_secretsmanager_name]
  }
}

data "aws_secretsmanager_secret_version" "elasticache" {
  secret_id = data.aws_secretsmanager_secrets.elasticache.id
}

locals {
  REDIS_MASTER_URL    = jsondecode(data.aws_secretsmanager_secret_version.elasticache.secret_string)["REDIS_MASTER_URL"]
  REDIS_NOAOF_URL     = jsondecode(data.aws_secretsmanager_secret_version.elasticache.secret_string)["REDIS_NOAOF_URL"]
  REDIS_TIMEOUT_URL   = jsondecode(data.aws_secretsmanager_secret_version.elasticache.secret_string)["REDIS_TIMEOUT_URL"]
  REDIS_WEBSOCKET_URL = jsondecode(data.aws_secretsmanager_secret_version.elasticache.secret_string)["REDIS_WEBSOCKET_URL"]
}

#########################################
### get secret from rds secret manager
data "aws_secretsmanager_secrets" "rds" {
  filter {
    name   = "name"
    values = [var.rds_secretsmanager_name]
  }
}

data "aws_secretsmanager_secret_version" "rds" {
  secret_id = data.aws_secretsmanager_secrets.rds.id
}

locals {
  db1_reader_endpoint = jsondecode(data.aws_secretsmanager_secret_version.rds.secret_string)["db1_reader_endpoint"]
  db1_writer_endpoint = jsondecode(data.aws_secretsmanager_secret_version.rds.secret_string)["db1_writer_endpoint"]
  db2_reader_endpoint = jsondecode(data.aws_secretsmanager_secret_version.rds.secret_string)["db2_reader_endpoint"]
  db2_writer_endpoint = jsondecode(data.aws_secretsmanager_secret_version.rds.secret_string)["db2_writer_endpoint"]
}

