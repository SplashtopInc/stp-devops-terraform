data "aws_caller_identity" "current" {}

### get ami info
data "aws_ami" "beapp_node_ami" {
  most_recent = true
  owners      = [local.worker_ami_owner_id]

  filter {
    name   = "name"
    values = [local.worker_ami_linux]
  }
}
### get vpc info
data "aws_vpc" "stp-vpc-pub" {
  tags = {
    Name = "stp-vpc-pub-${var.region}"
  }
}

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