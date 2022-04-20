#########
# Output
#########
output "eks-be" {
  value = {
    "cluster_id"           = module.eks-be.cluster_id
    "cluster_endpoint"     = module.eks-be.cluster_endpoint
    "cluster_iam_role_arn" = module.eks-be.cluster_iam_role_arn
    "worker_iam_role_arn"  = module.eks-be.worker_iam_role_arn
  }
}
