#########
# Output
#########
output "VPC-BE" {
  value = {
    "01_VPC_Name"                   = module.vpc-be.name
    "02_VPC_ID"                     = module.vpc-be.vpc_id
    "03_VPC_CIDR_Block"             = module.vpc-be.vpc_cidr_block
    "04_Private_Subnet_IDs"         = module.vpc-be.private_subnets
    "05_Private_Subnet_CIDR_Blocks" = module.vpc-be.private_subnets_cidr_blocks
    "06_Public_Subnet_IDs"          = module.vpc-be.public_subnets
    "07_Public_Subnet_CIDR_Blocks"  = module.vpc-be.public_subnets_cidr_blocks
    "08_Internet_Gateway_ID"        = module.vpc-be.igw_id
    "09_NAT_Public_IP(s)"           = var.vpc_backend_reuse_nat_ips ? compact(data.aws_eip.be_alloc_eip[*].public_ip) : module.vpc-be.nat_public_ips
    "10_NAT_Gateway_ID(s)"          = module.vpc-be.natgw_ids
    "domain"                        = var.domain
  }
}

#########
# Output
#########
output "vpc-be-id" {
  value = module.vpc-be.vpc_id
}

output "stp-vpc-backend-private-subnet-ids" {
  value = data.aws_subnet_ids.stp-vpc-backend-private.ids
}