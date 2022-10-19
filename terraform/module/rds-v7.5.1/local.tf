locals {
  cluster_name_env    = substr(var.environment, 0, 4)
  cluster_name_region = join("", [substr(replace(var.region, "-", ""), 0, 3), regex("\\d$", var.region)])
  cluster_name_suffix = "${local.cluster_name_env}-${local.cluster_name_region}-${random_string.suffix.result}"
}

locals {
  db1_name = "db1-${local.cluster_name_suffix}"

  db1_identifier                   = "${local.db1_name}-aurora"
  db1_parameter_group_name         = "${local.db1_name}-aurora-mysql57"
  db1_cluster_parameter_group_name = "${local.db1_name}-aurora-mysql57-cluster"

  db2_name = "db2-${local.cluster_name_suffix}"

  db2_identifier                   = "${local.db2_name}-aurora"
  db2_parameter_group_name         = "${local.db2_name}-aurora-mysql57"
  db2_cluster_parameter_group_name = "${local.db2_name}-aurora-mysql57-cluster"
}

locals {
  tags = {
    Project     = var.project
    Environment = var.environment
  }
}