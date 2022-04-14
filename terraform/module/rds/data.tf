data "aws_vpc" "stp-vpc-db" {
  tags = {
    Name = "stp-vpc-db-${var.region}"
  }
}

data "aws_subnet_ids" "stp-vpc-db-all" {
  vpc_id = data.aws_vpc.stp-vpc-db.id

  tags = {
    Name = "stp-vpc-db-private-${var.region}*"
  }
}