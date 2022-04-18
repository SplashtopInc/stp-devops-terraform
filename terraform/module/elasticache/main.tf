resource "random_password" "redis_auth_token" {
  count             = length(var.redis_nodes_list)
  length            = 32
  lower             = true
  upper             = true
  number            = true
  special           = false       # No special for now
  override_special  = "!&#$^<>-"  # EC Redis only support restricted characters
}

resource "aws_security_group" "redis-sg" {
  description = "Security Group - ${var.redis_nodes_list[count.index]}-${local.cluster_name_suffix}"
  count         = length(var.redis_nodes_list)
  name_prefix   = "${var.redis_nodes_list[count.index]}-${local.cluster_name_suffix}-sg"
  vpc_id        = data.aws_vpc.stp-vpc-db.id

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

  tags          = {
    Name = "${var.redis_nodes_list[count.index]}-${local.cluster_name_suffix}-sg"
  }
}

resource "aws_elasticache_subnet_group" "redis-subnet-group" {
  count      = length(var.redis_nodes_list)
  name       = "${var.redis_nodes_list[count.index]}-${local.cluster_name_suffix}-subnetgroup"
  subnet_ids = data.aws_subnet_ids.stp-vpc-db-private.ids
}

resource "aws_elasticache_replication_group" "redis-replica-group" {
  count                         = length(var.redis_nodes_list)
  replication_group_id          = "${var.redis_nodes_list[count.index]}-${local.cluster_name_suffix}"
  replication_group_description = "Splashtop - Redis Replication Group"
  engine                        = "redis"
  engine_version                = var.redis_engine_ver
  node_type                     = var.redis_node_type
  automatic_failover_enabled    = var.redis_failover
  multi_az_enabled              = var.redis_multiaz
  number_cache_clusters         = var.redis_num_cache_nodes
  parameter_group_name          = aws_elasticache_parameter_group.redis-para-group[count.index].name
  port                          = 6379
  subnet_group_name             = aws_elasticache_subnet_group.redis-subnet-group[count.index].name
  security_group_ids            = ["${aws_security_group.redis-sg[count.index].id}"]
  transit_encryption_enabled    = true
  at_rest_encryption_enabled    = true
  auth_token                    = random_password.redis_auth_token[count.index].result
  maintenance_window            = var.redis_maintenance_window[count.index]
  snapshot_window               = var.redis_snapshot_window[count.index]
  snapshot_retention_limit      = var.redis_snapshot_retention_limit

  auto_minor_version_upgrade    = true
  apply_immediately             = true

  notification_topic_arn        = var.redis_sns_arn
}