#### be2db
module "vpc-peering-be2db" {
  source  = "cloudposse/vpc-peering/aws"
  version = "0.9.2"

  namespace = "stp"
  stage     = var.environment
  name      = "be2db"

  auto_accept                               = true
  requestor_allow_remote_vpc_dns_resolution = false
  acceptor_allow_remote_vpc_dns_resolution  = true
  requestor_vpc_id                          = (var.vpc_be_id != "" ? var.vpc_be_id : data.aws_vpc.stp-vpc-be.id)
  acceptor_vpc_id                           = (var.vpc_db_id != "" ? var.vpc_db_id : data.aws_vpc.stp-vpc-db.id)
  create_timeout                            = "5m"
  update_timeout                            = "5m"
  delete_timeout                            = "10m"

  tags = {
    Name        = "vpc-peering-be2db"
    Project     = var.project
    Environment = var.environment
    Module      = var.module
  }
}

#####

module "vpc-peering-pub2db" {
  source  = "cloudposse/vpc-peering/aws"
  version = "0.9.2"

  namespace = "stp"
  stage     = var.environment
  name      = "pub2db"

  auto_accept                               = true
  requestor_allow_remote_vpc_dns_resolution = false
  acceptor_allow_remote_vpc_dns_resolution  = true
  requestor_vpc_id                          = (var.vpc_pub_id != "" ? var.vpc_pub_id : data.aws_vpc.stp-vpc-pub.id)
  acceptor_vpc_id                           = (var.vpc_db_id != "" ? var.vpc_db_id : data.aws_vpc.stp-vpc-db.id)
  create_timeout                            = "5m"
  update_timeout                            = "5m"
  delete_timeout                            = "10m"

  tags = {
    Name        = "vpc-peering-pub2db"
    Project     = var.project
    Environment = var.environment
    Module      = var.module
  }
}


module "vpc-peering-pub2be" {
  source  = "cloudposse/vpc-peering/aws"
  version = "0.9.2"

  namespace = "stp"
  stage     = var.environment
  name      = "pub2be"

  auto_accept                               = true
  requestor_allow_remote_vpc_dns_resolution = true
  acceptor_allow_remote_vpc_dns_resolution  = true
  requestor_vpc_id                          = (var.vpc_pub_id != "" ? var.vpc_pub_id : data.aws_vpc.stp-vpc-pub.id)
  acceptor_vpc_id                           = (var.vpc_be_id != "" ? var.vpc_be_id : data.aws_vpc.stp-vpc-be.id)
  create_timeout                            = "5m"
  update_timeout                            = "5m"
  delete_timeout                            = "10m"

  tags = {
    Name        = "vpc-peering-pub2be"
    Project     = var.project
    Environment = var.environment
    Module      = var.module
  }
}
