provider "kubernetes" {
  alias                  = "k8s-beapp"
  host                   = data.aws_eks_cluster.eks-be.endpoint
  token                  = data.aws_eks_cluster_auth.eks-be.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks-be.certificate_authority.0.data)
}