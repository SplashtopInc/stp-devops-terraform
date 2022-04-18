### Output ###
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
