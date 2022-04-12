module "vpc-db" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.6.0"

  name                 = "stp-vpc-db"
  cidr                 = var.vpc_db_cidr
  azs                  = slice(data.aws_availability_zones.available.names, var.vpc_db_az_start, var.vpc_db_az_end)
  private_subnets      = var.vpc_db_pri_subnets
  public_subnets       = var.vpc_db_pub_subnets
  enable_nat_gateway   = false
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_ipv6          = false

  vpc_tags = {
    Name        = "${module.vpc-db.name}-${var.region}"
    Project     = var.project
    Environment = var.environment
  }
}

