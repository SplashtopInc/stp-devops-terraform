resource "random_string" "suffix" {
  length  = 8
  upper   = false # no upper for RDS related resources naming rule
  special = false
}

locals {
  cluster_name_project = lower(var.project)
  cluster_name_region  = join("", [substr(replace(var.region, "-", ""), 0, 3), regex("\\d$", var.region)])
  cluster_name_env     = substr(var.environment, 0, 4)
  cluster_name_suffix  = "${local.cluster_name_env}-${local.cluster_name_region}-${random_string.suffix.result}"

  elasticache_cluster_domain = "es-db-${local.cluster_name_suffix}"
}