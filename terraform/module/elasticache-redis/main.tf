resource "random_string" "suffix" {
  count   = var.enabled ? 1 : 0
  length  = 8
  upper   = false # no upper for RDS related resources naming rule
  special = false
}

resource "random_password" "redis_auth_token" {
  count            = var.enabled ? length(var.redis_nodes_list) : 0
  length           = 32
  lower            = true
  upper            = true
  numeric          = true
  special          = false      # No special for now
  override_special = "!&#$^<>-" # EC Redis only support restricted characters
}

resource "aws_security_group" "redis-sg" {
  description = "Security Group - ${var.redis_nodes_list[count.index]}-${local.cluster_name_suffix}"
  count       = var.enabled ? length(var.redis_nodes_list) : 0
  name_prefix = "${var.redis_nodes_list[count.index]}-${local.cluster_name_suffix}-sg"
  vpc_id      = data.aws_vpc.stp-vpc-db.id

  # Allow internal
  ingress {
    description = "Allow access from local LAN"
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = [
      "10.0.0.0/8",
      "172.16.0.0/12",
      "192.168.0.0/16"
    ]
  }

  egress {
    description = "Allow all to local LAN"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [
      "10.0.0.0/8",
      "172.16.0.0/12",
      "192.168.0.0/16"
    ]
  }

  tags = {
    Name = "${var.redis_nodes_list[count.index]}-${local.cluster_name_suffix}-sg"
  }
}

resource "aws_elasticache_subnet_group" "redis-subnet-group" {
  count      = var.enabled ? length(var.redis_nodes_list) : 0
  name       = "${var.redis_nodes_list[count.index]}-${local.cluster_name_suffix}-subnetgroup"
  subnet_ids = length(var.vpc-db-private-subnets) != 0 ? var.vpc-db-private-subnets : data.aws_subnets.stp-vpc-db-private.ids
}

resource "aws_elasticache_replication_group" "redis-replica-group" {
  #checkov:skip=CKV_AWS_191:not use CMK
  count                      = var.enabled ? length(var.redis_nodes_list) : 0
  replication_group_id       = "${var.redis_nodes_list[count.index]}-${local.cluster_name_suffix}"
  description                = "Splashtop - Redis Replication Group"
  engine                     = "redis"
  engine_version             = var.redis_engine_ver
  node_type                  = var.redis_node_type
  automatic_failover_enabled = var.redis_failover
  multi_az_enabled           = var.redis_multiaz
  num_cache_clusters         = var.redis_num_cache_nodes
  parameter_group_name       = aws_elasticache_parameter_group.redis-para-group[count.index].name
  port                       = 6379
  subnet_group_name          = aws_elasticache_subnet_group.redis-subnet-group[count.index].name
  security_group_ids         = ["${aws_security_group.redis-sg[count.index].id}"]
  transit_encryption_enabled = true
  at_rest_encryption_enabled = true
  auth_token                 = random_password.redis_auth_token[count.index].result
  maintenance_window         = var.redis_maintenance_window[count.index]
  snapshot_window            = var.redis_snapshot_window[count.index]
  snapshot_retention_limit   = var.redis_snapshot_retention_limit

  auto_minor_version_upgrade = true
  apply_immediately          = true

  notification_topic_arn = var.redis_sns_arn
}