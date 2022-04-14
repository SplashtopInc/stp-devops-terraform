#########
# Output
#########
output "vpc-peer" {
  value = {
    "01_be2db_connection_ID"  = module.vpc-peering-be2db.connection_id
    "02_be2db_accept_status"  = module.vpc-peering-be2db.accept_status
    "03_pub2db_connection_ID" = module.vpc-peering-pub2db.connection_id
    "04_pub2db_accept_status" = module.vpc-peering-pub2db.accept_status
    "05_pub2be_connection_ID" = module.vpc-peering-pub2be.connection_id
    "06_pub2be_accept_status" = module.vpc-peering-pub2be.accept_status
  }
}

