output "Redis_Nodes" {
  value = {
    "01_Name"             = aws_elasticache_replication_group.redis-replica-group[*].replication_group_id
    "02_Primary_Endpoint" = aws_elasticache_replication_group.redis-replica-group[*].primary_endpoint_address
    "03_Reader_Endpoint"  = aws_elasticache_replication_group.redis-replica-group[*].reader_endpoint_address
  }
}
output "Redis_AuthToken" {
  sensitive = true
  value = {
    "03_Auth_Token" = aws_elasticache_replication_group.redis-replica-group[*].auth_token
  }
}

# output "master_redis_address"{
#   value = aws_elasticache_replication_group.redis-replica-group[0].primary_endpoint_address
# }
# output "noaof_redis_address"{
#   value = aws_elasticache_replication_group.redis-replica-group[1].primary_endpoint_address
# }
# output "timeout_redis_address"{
#   value = aws_elasticache_replication_group.redis-replica-group[2].primary_endpoint_address
# }
# output "websocket_redis_address"{
#   value = aws_elasticache_replication_group.redis-replica-group[3].primary_endpoint_address
# }


output "master_redis_address" {
  value = join(", ", [for s in aws_elasticache_replication_group.redis-replica-group[*].primary_endpoint_address : s if length(regexall("redis-master.*", s)) > 0])
}
output "noaof_redis_address" {
  value = join(", ", [for s in aws_elasticache_replication_group.redis-replica-group[*].primary_endpoint_address : s if length(regexall("redis-noaof.*", s)) > 0])
}
output "timeout_redis_address" {
  value = join(", ", [for s in aws_elasticache_replication_group.redis-replica-group[*].primary_endpoint_address : s if length(regexall("redis-timeout.*", s)) > 0])
}
output "websocket_redis_address" {
  value = join(", ", [for s in aws_elasticache_replication_group.redis-replica-group[*].primary_endpoint_address : s if length(regexall("redis-websocket.*", s)) > 0])
}
