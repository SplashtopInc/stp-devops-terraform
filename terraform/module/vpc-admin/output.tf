#########
# Output
#########
output "vpc_admin" {
  value = {
    "01_VPC_Name"                       = module.vpc-admin.name
    "02_VPC_ID"                         = module.vpc-admin.vpc_id
    "03_VPC_CIDR_Block"                 = module.vpc-admin.vpc_cidr_block
    "04_Private_Subnet_IDs"             = module.vpc-admin.private_subnets
    "05_Private_Subnet_CIDR_Blocks"     = module.vpc-admin.private_subnets_cidr_blocks
    "06_Public_Subnet_IDs"              = module.vpc-admin.public_subnets
    "07_Public_Subnet_CIDR_Blocks"      = module.vpc-admin.public_subnets_cidr_blocks
    "08_Internet_Gateway_ID"            = module.vpc-admin.igw_id
    "09_NAT_Public_IP(s)"               = var.vpc_admin_reuse_nat_ips ? compact(data.aws_eip.pub_alloc_eip[*].public_ip) : module.vpc-admin.nat_public_ips
    "10_NAT_Gateway_ID(s)"              = module.vpc-admin.natgw_ids
    "11_SG_Office_Whitelist_4_Prod"     = resource.aws_security_group.stp-office-ip-whitelist[*].name
    "12_SG_Office_Whitelist_4_nonProd"  = resource.aws_security_group.stp-ip-whitelist-office-nonprod[*].name
    "13_SG_Outside_Whitelist_4_nonProd" = resource.aws_security_group.stp-ip-whitelist-outside-nonprod[*].name
  }
}


output "vpc-admin-id" {
  value = module.vpc-admin.vpc_id
}

output "stp-vpc-admin-private-subnet-ids" {
  value = data.aws_subnets.stp-vpc-admin-private.ids
}

output "stp-vpc-admin-public-subnet-ids" {
  value = data.aws_subnets.stp-vpc-admin-public.ids
}