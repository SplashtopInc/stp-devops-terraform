provider "kubernetes" {
  alias                  = "k8s-bottlerocket"
  host                   = data.aws_eks_cluster.eks-bottlerocket.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks-bottlerocket.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.eks-bottlerocket.token
}
