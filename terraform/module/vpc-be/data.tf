# data "aws_route53_zone" "deploy_zone" {
#   name = var.domain
# }

data "aws_availability_zones" "available" {
  state = "available"
}
data "aws_caller_identity" "current" {}

data "aws_subnet_ids" "stp-vpc-backend-private" {
  vpc_id = module.vpc-be.vpc_id

  filter {
    name = "tag:Name"
    values = [
      "stp-vpc-backend-private-${var.region}*"
    ]
  }

  depends_on = [module.vpc-be]
}

### Get pre-allocated EIP(s) for NAT
data "aws_eip" "be_alloc_eip" {
  count = var.vpc_backend_reuse_nat_ips ? length(var.vpc_backend_nat_eip_ids) : 0
  id    = var.vpc_backend_nat_eip_ids[count.index]
}