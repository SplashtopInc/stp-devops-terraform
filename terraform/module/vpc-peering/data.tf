# Lookup requestor VPC so that we can reference the CIDR

data "aws_vpc" "stp-vpc-be" {
  tags = {
    Name = "stp-vpc-backend-${var.region}"
  }
}

data "aws_vpc" "stp-vpc-pub" {
  tags = {
    Name = "stp-vpc-pub-${var.region}"
  }
}

data "aws_vpc" "stp-vpc-db" {
  tags = {
    Name = "stp-vpc-db-${var.region}"
  }
}