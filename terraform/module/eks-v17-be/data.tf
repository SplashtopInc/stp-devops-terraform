################################################################################
# Kubernetes provider configuration
################################################################################
data "aws_eks_cluster" "eks-be" {
  name = module.eks-be.cluster_id
}

data "aws_eks_cluster_auth" "eks-be" {
  name = module.eks-be.cluster_id
}

data "aws_caller_identity" "current" {}

data "aws_ami" "bottlerocket_ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["bottlerocket-aws-k8s-${var.eks_cluster_version}-x86_64-*"]
  }
}

data "aws_ami" "beapp_node_ami" {
  most_recent = true
  owners      = [local.worker_ami_owner_id]

  filter {
    name   = "name"
    values = [local.worker_ami_linux]
  }
}

data "aws_vpc" "stp-vpc-pub" {
  tags = {
    Name = "stp-vpc-pub-${var.region}"
  }
}

data "aws_subnet_ids" "stp-vpc-pub-private" {
  vpc_id = data.aws_vpc.stp-vpc-pub.id

  filter {
    name = "tag:Name"
    values = [
      "stp-vpc-pub-private-${var.region}*"
    ]
  }
}
