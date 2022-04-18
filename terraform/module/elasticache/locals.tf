locals {
  cluster_name_env    = substr(var.environment, 0, 4)
  cluster_name_region = join("", [substr(replace(var.region, "-", ""), 0, 3), regex("\\d$", var.region)])
  cluster_name_suffix = "${local.cluster_name_env}-${local.cluster_name_region}-${random_string.suffix.result}"
}