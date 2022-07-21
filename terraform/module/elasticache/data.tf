data "aws_vpc" "stp-vpc-db" {
  tags = {
    Name = "stp-vpc-db-${var.region}"
  }
}

data "aws_subnets" "stp-vpc-db-private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.stp-vpc-db.id]
  }

  filter {
    name = "tag:Name"
    values = [
      "stp-vpc-db-private-${var.region}*"
    ]
  }
}


