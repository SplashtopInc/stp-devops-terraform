### Output ###
output "db1" {
  value = {
    "rw_endpoint" = module.db1.cluster_endpoint
    "ro_endpoint" = module.db1.cluster_reader_endpoint
  }
}
output "db2" {
  value = {
    "rw_endpoint" = var.db2_enable == true ? module.db2.cluster_endpoint : "N/A"
    "ro_endpoint" = var.db2_enable == true ? module.db2.cluster_reader_endpoint : "N/A"
  }
}
output "Aurora-Cluster-DB1" {
  value = {
    "DB1-Writer-Endpoint" = module.db1.cluster_endpoint
    "DB1-Reader-Endpoint" = module.db1.cluster_reader_endpoint
  }
}
output "Aurora-Cluster-DB2" {
  value = {
    "DB2-Writer-Endpoint" = var.db2_enable == true ? module.db2.cluster_endpoint : "N/A"
    "DB2-Reader-Endpoint" = var.db2_enable == true ? module.db2.cluster_reader_endpoint : "N/A"
  }
}
output "DB-Password" {
  sensitive = true
  value = {
    "DB1" = module.db1.cluster_master_password
    "DB2" = var.db2_enable == true ? module.db2.cluster_master_password : "N/A"
  }
}
