################################################################################
# Kubernetes provider configuration
################################################################################
data "aws_eks_cluster" "eks-bottlerocket" {
  name = module.eks-bottlerocket.cluster_id
}

data "aws_eks_cluster_auth" "eks-bottlerocket" {
  name = module.eks-bottlerocket.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks-bottlerocket.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks-bottlerocket.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks-bottlerocket.token
}

data "aws_caller_identity" "current" {}


data "aws_ami" "bottlerocket_ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["bottlerocket-aws-k8s-${var.k8s_version}-x86_64-*"]
  }
}

// data "aws_eks_node_group" "influxdb" {
//   cluster_name    = local.bottlerocket_cluster_name
//   node_group_name = "influxdb"
// }