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

output "cluster_name_suffix" {
  value = "${local.cluster_name_env}-${local.cluster_name_region}-${random_string.suffix.result}"
}

output "app_cluster_name" {
  value = local.app_cluster_name
}