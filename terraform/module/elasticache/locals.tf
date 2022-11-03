resource "random_string" "suffix" {
  count   = var.enabled ? 1 : 0
  length  = 8
  upper   = false # no upper for RDS related resources naming rule
  special = false
}

locals {
  cluster_name_env    = substr(var.environment, 0, 4)
  cluster_name_region = join("", [substr(replace(var.region, "-", ""), 0, 3), regex("\\d$", var.region)])
  cluster_name_random = var.enabled ? random_string.suffix[0].result : ""

  cluster_name_suffix = "${local.cluster_name_env}-${local.cluster_name_region}-${local.cluster_name_random}"
}

locals {
  redis               = zipmap(aws_elasticache_replication_group.redis-replica-group[*].primary_endpoint_address, aws_elasticache_replication_group.redis-replica-group[*].auth_token)
  redis_url           = formatlist("rediss://%s@%s:6379", values(local.redis), keys(local.redis))
  master_redis_url    = join(", ", [for s in local.redis_url : s if length(regexall("redis-master.*", s)) > 0])
  noaof_redis_url     = join(", ", [for s in local.redis_url : s if length(regexall("redis-noaof.*", s)) > 0])
  timeout_redis_url   = join(", ", [for s in local.redis_url : s if length(regexall("redis-timeout.*", s)) > 0])
  websocket_redis_url = join(", ", [for s in local.redis_url : s if length(regexall("redis-websocket.*", s)) > 0])
}