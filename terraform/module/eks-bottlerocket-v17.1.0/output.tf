output "eks-bottlerocket" {
  value = {
    "cluster_id"           = module.eks-bottlerocket.cluster_id
    "cluster_endpoint"     = module.eks-bottlerocket.cluster_endpoint
    "cluster_iam_role_arn" = module.eks-bottlerocket.cluster_iam_role_arn
    "worker_iam_role_arn"  = module.eks-bottlerocket.worker_iam_role_arn
    "cluster_version"      = module.eks-bottlerocket.cluster_version
  }
}

#########
# Output
#########
output "eks-bottlerocket-cluster-id" {
  value = module.eks-bottlerocket.cluster_id
}

output "eks-bottlerocket-cluster-endpoint" {
  value = module.eks-bottlerocket.cluster_endpoint
}

output "eks-bottlerocket-cluster-ca-data" {
  value = base64decode(data.aws_eks_cluster.eks-bottlerocket.certificate_authority[0].data)
}

output "eks-bottlerocket-cluster-ca" {
  value = data.aws_eks_cluster.eks-bottlerocket.certificate_authority[0].data
}

output "eks-bottlerocket-kubeconfig" {
  value = local.kubeconfig
}
// output "eks-bottlerocket-cluster-token" {
//   value = data.aws_eks_cluster_auth.eks-bottlerocket.token
//   sensitive = true
// }

// output "eks-bottlerocket-cluster-influxdb-node-group" {
//   value = data.aws_eks_node_group.influxdb.arn
// }