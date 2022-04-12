#########
# Output
#########
output "vpc_db" {
  value = {
    "01_VPC_Name"                   = module.vpc-db.name
    "02_VPC_ID"                     = module.vpc-db.vpc_id
    "03_VPC_CIDR_Block"             = module.vpc-db.vpc_cidr_block
    "04_Private_Subnet_IDs"         = module.vpc-db.private_subnets
    "05_Private_Subnet_CIDR_Blocks" = module.vpc-db.private_subnets_cidr_blocks
    "06_Public_Subnet_IDs"          = module.vpc-db.public_subnets
    "07_Public_Subnet_CIDR_Blocks"  = module.vpc-db.public_subnets_cidr_blocks
    "08_Internet_Gateway_ID"        = module.vpc-db.igw_id
    "09_NAT_Public_IP(s)"           = "N/A"
    "10_NAT_Gateway_ID(s)"          = "N/A"
  }
}

#########
# Output
#########
output "vpc-db-id" {
  value = module.vpc-db.vpc_id
}

output "stp-vpc-db-private-subnet-ids" {
  value = data.aws_subnet_ids.stp-vpc-db-private.ids
}


output "stp-vpc-db-all-subnet-ids" {
  value = data.aws_subnet_ids.stp-vpc-db-all.ids
}