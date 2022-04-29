locals {
  # substr(string, offset, length)
  cluster_name_project = lower(var.project)
  cluster_name_region  = join("", [substr(replace(var.region, "-", ""), 0, 3), regex("\\d$", var.region)])
  cluster_name_env     = substr(var.environment, 0, 4)
  cluster_name_account = var.account
  cluster_name_suffix  = "${local.cluster_name_account}-${local.cluster_name_env}-${local.cluster_name_region}-${random_string.suffix.result}"


  # cluster name 
  bottlerocket_cluster_name = "${local.cluster_name_project}-${local.cluster_name_suffix}"

  template_vars = {
    cluster_name     = module.eks-bottlerocket.cluster_id
    cluster_endpoint = module.eks-bottlerocket.cluster_endpoint
    cluster_ca       = data.aws_eks_cluster.eks-bottlerocket.certificate_authority[0].data
    cluster_profile  = var.profile
    cluster_region   = var.region
  }

  kubeconfig = templatefile("./kubeconfig.tpl", local.template_vars)
}