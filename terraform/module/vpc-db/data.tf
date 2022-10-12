data "aws_availability_zones" "available" {
  state = "available"
}
data "aws_caller_identity" "current" {}

data "aws_subnets" "stp-vpc-db-private" {
  filter {
    name   = "vpc-id"
    values = [module.vpc-db.vpc_id]
  }
  filter {
    name   = "tag:Name"
    values = ["stp-vpc-db-private-${var.region}*"]
  }

  depends_on = [module.vpc-db]
}

data "aws_subnets" "stp-vpc-db-all" {
  filter {
    name   = "vpc-id"
    values = [module.vpc-db.vpc_id]
  }
  filter {
    name   = "tag:Name"
    values = ["stp-vpc-db-*"]
  }

  depends_on = [module.vpc-db]
}