resource "aws_elasticache_parameter_group" "redis-para-group" {
  count       = var.enabled ? length(var.redis_nodes_list) : 0
  description = "Splashtop parameters"
  family      = var.redis_parameter_group_family
  name        = join("-", [var.redis_nodes_list[count.index], local.cluster_name_suffix, replace(var.redis_parameter_group_family, ".", "")])

  parameter {
    name  = "notify-keyspace-events"
    value = var.redis_para_notify_keyspace_events_list[count.index]
  }
  parameter {
    name  = "timeout"
    value = var.redis_para_timeout_list[count.index]
  }
}
