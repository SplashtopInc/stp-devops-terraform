data "aws_caller_identity" "current" {}

### get ami info
data "aws_ami" "cloudbuild_node_ami" {
  most_recent = true
  owners      = [local.worker_ami_owner_id]

  filter {
    name   = "name"
    values = [local.worker_ami_linux]
  }
}
### get vpc info
data "aws_vpc" "stp-vpc-backend" {
  tags = {
    Name = "stp-vpc-backend-${var.region}"
  }
}

data "aws_subnets" "stp-vpc-backend-private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.stp-vpc-backend.id]
  }

  filter {
    name = "tag:Name"
    values = [
      "stp-vpc-backend-private-${var.region}*"
    ]
  }
}