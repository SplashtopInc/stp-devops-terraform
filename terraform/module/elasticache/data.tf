data "aws_vpc" "stp-vpc-db" {
  tags = {
    Name = "stp-vpc-db-${var.region}"
  }
}

data "aws_subnet_ids" "stp-vpc-db-private" {
  vpc_id = data.aws_vpc.stp-vpc-db.id

  filter {
    name   = "tag:Name"
    values = [
      "stp-vpc-db-private-${var.region}*"
    ]
  }
}