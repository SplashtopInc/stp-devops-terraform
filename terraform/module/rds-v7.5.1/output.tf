# # aws_db_subnet_group
# output "db_subnet_group_name" {
#   description = "The db subnet group name"
#   value       = module.aurora.db_subnet_group_name
# }

# # aws_rds_cluster
# output "cluster_arn" {
#   description = "Amazon Resource Name (ARN) of cluster"
#   value       = module.aurora.cluster_arn
# }

# output "cluster_id" {
#   description = "The RDS Cluster Identifier"
#   value       = module.aurora.cluster_id
# }

# output "cluster_resource_id" {
#   description = "The RDS Cluster Resource ID"
#   value       = module.aurora.cluster_resource_id
# }

# output "cluster_members" {
#   description = "List of RDS Instances that are a part of this cluster"
#   value       = module.aurora.cluster_members
# }

# output "cluster_endpoint" {
#   description = "Writer endpoint for the cluster"
#   value       = module.aurora.cluster_endpoint
# }

# output "cluster_reader_endpoint" {
#   description = "A read-only endpoint for the cluster, automatically load-balanced across replicas"
#   value       = module.aurora.cluster_reader_endpoint
# }

# output "cluster_engine_version_actual" {
#   description = "The running version of the cluster database"
#   value       = module.aurora.cluster_engine_version_actual
# }

# # database_name is not set on `aws_rds_cluster` resource if it was not specified, so can't be used in output
# output "cluster_database_name" {
#   description = "Name for an automatically created database on cluster creation"
#   value       = module.aurora.cluster_database_name
# }

# output "cluster_port" {
#   description = "The database port"
#   value       = module.aurora.cluster_port
# }

# output "cluster_master_password" {
#   description = "The database master password"
#   value       = module.aurora.cluster_master_password
#   sensitive   = true
# }

# output "cluster_master_username" {
#   description = "The database master username"
#   value       = module.aurora.cluster_master_username
#   sensitive   = true
# }

# output "cluster_hosted_zone_id" {
#   description = "The Route53 Hosted Zone ID of the endpoint"
#   value       = module.aurora.cluster_hosted_zone_id
# }

# # aws_rds_cluster_instances
# output "cluster_instances" {
#   description = "A map of cluster instances and their attributes"
#   value       = module.aurora.cluster_instances
# }

# # aws_rds_cluster_endpoint
# output "additional_cluster_endpoints" {
#   description = "A map of additional cluster endpoints and their attributes"
#   value       = module.aurora.additional_cluster_endpoints
# }

# # aws_rds_cluster_role_association
# output "cluster_role_associations" {
#   description = "A map of IAM roles associated with the cluster and their attributes"
#   value       = module.aurora.cluster_role_associations
# }

# # Enhanced monitoring role
# output "enhanced_monitoring_iam_role_name" {
#   description = "The name of the enhanced monitoring role"
#   value       = module.aurora.enhanced_monitoring_iam_role_name
# }

# output "enhanced_monitoring_iam_role_arn" {
#   description = "The Amazon Resource Name (ARN) specifying the enhanced monitoring role"
#   value       = module.aurora.enhanced_monitoring_iam_role_arn
# }

# output "enhanced_monitoring_iam_role_unique_id" {
#   description = "Stable and unique string identifying the enhanced monitoring role"
#   value       = module.aurora.enhanced_monitoring_iam_role_unique_id
# }

# # aws_security_group
# output "security_group_id" {
#   description = "The security group ID of the cluster"
#   value       = module.aurora.security_group_id
# }

################################################################################
# Parameter Group
################################################################################

# output "db_cluster_parameter_group_arn" {
#   description = "The ARN of the DB cluster parameter group created"
#   value       = module.aurora.db_cluster_parameter_group_arn
# }

# output "db_cluster_parameter_group_id" {
#   description = "The ID of the DB cluster parameter group created"
#   value       = module.aurora.db_cluster_parameter_group_id
# }

# output "db_parameter_group_arn" {
#   description = "The ARN of the DB parameter group created"
#   value       = module.aurora.db_parameter_group_arn
# }

# output "db_parameter_group_id" {
#   description = "The ID of the DB parameter group created"
#   value       = module.aurora.db_parameter_group_id
# }

### Output ###

output "Aurora-Cluster-DB1" {
  description = "Detail of the DB1 cluster"
  value = {
    "DB1-Writer-Endpoint" = module.db1.cluster_endpoint
    "DB1-Reader-Endpoint" = module.db1.cluster_reader_endpoint
  }
}
output "Aurora-Cluster-DB2" {
  description = "Detail of the DB2 cluster"
  value = {
    "DB2-Writer-Endpoint" = var.db2_enable == true ? module.db2.cluster_endpoint : "N/A"
    "DB2-Reader-Endpoint" = var.db2_enable == true ? module.db2.cluster_reader_endpoint : "N/A"
  }
}
output "DB-Password" {
  description = "master user password"
  sensitive   = true
  value = {
    "DB1" = module.db1.cluster_master_password
    "DB2" = var.db2_enable == true ? module.db2.cluster_master_password : "N/A"
  }
}

output "db1-writer-endpoint" {
  description = "Writer endpoint for the db1 cluster"
  value       = module.db1.cluster_endpoint
}

output "db1-reader-endpoint" {
  description = "A read-only endpoint for the cluster, automatically load-balanced across replicas"
  value       = module.db1.cluster_reader_endpoint
}

output "db2-writer-endpoint" {
  description = "Writer endpoint for the db2 cluster"
  value       = module.db2.cluster_endpoint
}

output "db2-reader-endpoint" {
  description = "A read-only endpoint for the cluster, automatically load-balanced across replicas"
  value       = module.db2.cluster_reader_endpoint
}