#########
# Output
#########
output "vpc-info" {
  value = {
    "01_VPC_Name"                   = module.vpc.name
    "02_VPC_ID"                     = module.vpc.vpc_id
    "03_VPC_CIDR_Block"             = module.vpc.vpc_cidr_block
    "04_Private_Subnet_IDs"         = module.vpc.private_subnets
    "05_Private_Subnet_CIDR_Blocks" = module.vpc.private_subnets_cidr_blocks
    "06_Public_Subnet_IDs"          = module.vpc.public_subnets
    "07_Public_Subnet_CIDR_Blocks"  = module.vpc.public_subnets_cidr_blocks
    "08_Internet_Gateway_ID"        = module.vpc.igw_id
    "09_NAT_Public_IP(s)"           = module.vpc.nat_public_ips
    "10_NAT_Gateway_ID(s)"          = module.vpc.natgw_ids
    "11_database_subnet_group_name" = module.vpc.database_subnet_group_name
  }
}

#########
# Output
#########
output "vpc-id" {
  value = module.vpc.vpc_id
}

output "vpc-database-subnet" {
  value = module.vpc.database_subnet_group_name
}

output "vpc-cidr-block" {
  value = [module.vpc.vpc_cidr_block]
}

output "vpc-cidr-block-str" {
  value = module.vpc.vpc_cidr_block
}

output "stp-vpc-private-subnet-ids" {
  value = data.aws_subnets.stp-vpc-private.ids
}

output "stp-vpc-default-sg" {
  value = data.aws_security_groups.stp-vpc-sg.ids
}