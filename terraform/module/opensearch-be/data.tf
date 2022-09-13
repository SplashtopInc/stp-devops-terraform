data "aws_route53_zone" "deploy_zone" {
  name = var.domain
}

data "aws_availability_zones" "available" {
  state = "available"
}
data "aws_caller_identity" "current" {}


data "aws_vpc" "stp_vpc_db" {
  tags = {
    Name = "stp-vpc-db-${var.region}"
  }
}

data "aws_subnets" "stp_vpc_db_private" {

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.stp_vpc_db.id]
  }

  filter {
    name = "tag:Name"
    values = [
      "stp-vpc-db-private-${var.region}*"
    ]
  }
}

### Get VPC ID of "Public VPC"
data "aws_vpc" "stp-vpc-pub" {
  tags = {
    Name = "stp-vpc-pub-${var.region}"
  }
}

### Get private subnet IDs of "Public VPC" for reference
data "aws_subnets" "stp-vpc-pub-private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.stp-vpc-pub.id]
  }

  filter {
    name = "tag:Name"
    values = [
      "stp-vpc-pub-private-${var.region}*"
    ]
  }
}