locals {
  cluster_name_env    = substr(var.environment, 0, 4)
  cluster_name_region = join("", [substr(replace(var.region, "-", ""), 0, 3), regex("\\d$", var.region)])
  cluster_name_suffix = "${local.cluster_name_env}-${local.cluster_name_region}-${random_string.suffix[0].result}"
}

locals {
  redis     = zipmap(aws_elasticache_replication_group.redis-replica-group[*].primary_endpoint_address, aws_elasticache_replication_group.redis-replica-group[*].auth_token)
  redis_url = formatlist("rediss://%s@%s:6379", values(local.redis), keys(local.redis))
}