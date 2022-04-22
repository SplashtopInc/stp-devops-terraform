data "aws_caller_identity" "current" {}

data "aws_vpc" "stp_vpc_db" {
  tags = {
    Name = "stp-vpc-pub-${var.region}"
  }
}

data "aws_subnet_ids" "stp_vpc_db_private" {
  vpc_id = data.aws_vpc.stp_vpc_db.id

  filter {
    name = "tag:Name"
    values = [
      "stp-vpc-pub-private-${var.region}*"
    ]
  }
}

