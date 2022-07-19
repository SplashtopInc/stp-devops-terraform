data "aws_vpc" "stp-vpc-db" {
  tags = {
    Name = "stp-vpc-db-${var.region}"
  }
}

data "aws_subnets" "stp-vpc-db-all" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.stp-vpc-db.id]
  }
}