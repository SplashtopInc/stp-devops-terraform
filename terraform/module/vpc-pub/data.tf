# data "aws_route53_zone" "deploy_zone" {
#   name = var.domain
# }

data "aws_availability_zones" "available" {
  state = "available"
}
data "aws_caller_identity" "current" {}

data "aws_subnets" "stp-vpc-pub-private" {

  filter {
    name   = "vpc-id"
    values = [module.vpc-pub.vpc_id]
  }

  filter {
    name = "tag:Name"
    values = [
      "stp-vpc-pub-private-${var.region}*"
    ]
  }

  depends_on = [module.vpc-pub]
}

data "aws_subnets" "stp-vpc-pub-public" {

  filter {
    name   = "vpc-id"
    values = [module.vpc-pub.vpc_id]
  }

  filter {
    name = "tag:Name"
    values = [
      "stp-vpc-pub-public-${var.region}*"
    ]
  }

  depends_on = [module.vpc-pub]
}

### Get pre-allocated EIP(s) for NAT
data "aws_eip" "pub_alloc_eip" {
  count = var.vpc_pub_reuse_nat_ips ? length(var.vpc_pub_nat_eip_ids) : 0
  id    = var.vpc_pub_nat_eip_ids[count.index]
}