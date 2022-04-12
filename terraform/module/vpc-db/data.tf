data "aws_availability_zones" "available" {
  state = "available"
}
data "aws_caller_identity" "current" {}

data "aws_subnet_ids" "stp-vpc-db-private" {
  vpc_id = module.vpc-db.vpc_id

  filter {
    name = "tag:Name"
    values = [
      "stp-vpc-db-private-${var.region}*"
    ]
  }

  depends_on = [module.vpc-db]
}

data "aws_subnet_ids" "stp-vpc-db-all" {
  vpc_id = module.vpc-db.vpc_id

  filter {
    name = "tag:Name"
    values = [
      "stp-vpc-db-*"
    ]
  }

  depends_on = [module.vpc-db]
}