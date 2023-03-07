data "aws_availability_zones" "available" {
  state = "available"
}
data "aws_caller_identity" "current" {}

data "aws_subnets" "stp-vpc-admin-private" {

  filter {
    name   = "vpc-id"
    values = [module.vpc-admin.vpc_id]
  }

  filter {
    name = "tag:Name"
    values = [
      "stp-vpc-admin-private-${var.region}*"
    ]
  }

  depends_on = [module.vpc-admin]
}

data "aws_subnets" "stp-vpc-admin-public" {

  filter {
    name   = "vpc-id"
    values = [module.vpc-admin.vpc_id]
  }

  filter {
    name = "tag:Name"
    values = [
      "stp-vpc-admin-public-${var.region}*"
    ]
  }

  depends_on = [module.vpc-admin]
}

### Get pre-allocated EIP(s) for NAT
data "aws_eip" "pub_alloc_eip" {
  count = var.vpc_admin_reuse_nat_ips ? length(var.vpc_admin_nat_eip_ids) : 0
  id    = var.vpc_admin_nat_eip_ids[count.index]
}