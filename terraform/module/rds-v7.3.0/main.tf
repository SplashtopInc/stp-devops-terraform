module "db1" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "7.3.0"

  name = local.db1_identifier

  engine         = "aurora-mysql"
  engine_version = "5.7"
  instance_class = var.instance_class
  instances = {
    one = {}
    two = {}
  }
  # https://github.com/terraform-aws-modules/terraform-aws-rds-aurora#cluster-instance-configuration
  #
  # Writer: 1
  # Reader(s):
  # At least 2 readers (1 created directly, 1 created by appautoscaling)
  # At most 6 reader instances (1 created directly, 5 created by appautoscaling)
  # autoscaling_enabled      = true
  # autoscaling_min_capacity = 1
  # autoscaling_max_capacity = 5

  vpc_id  = var.vpc_db_vpc_id != "" ? var.vpc_db_vpc_id : data.aws_vpc.stp-vpc-db.id
  subnets = length(var.vpc-db-all-subnets) != 0 ? var.vpc-db-all-subnets : data.aws_subnets.stp-vpc-db-all.ids

  create_db_subnet_group = true
  create_security_group  = true
  allowed_cidr_blocks    = var.allowed_cidr_blocks
  publicly_accessible    = var.publicly_accessible

  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  master_username                     = var.master_username
  master_password                     = random_password.master.result
  create_random_password              = false

  apply_immediately   = true
  skip_final_snapshot = true
  monitoring_interval = var.monitoring_interval
  storage_encrypted   = var.storage_encrypted

  deletion_protection          = var.deletion_protection
  backup_retention_period      = var.backup_retention_period
  preferred_backup_window      = var.preferred_backup_window
  preferred_maintenance_window = var.preferred_maintenance_window
  auto_minor_version_upgrade   = var.auto_minor_version_upgrade

  enabled_cloudwatch_logs_exports = ["slowquery"] #["audit", "error", "general", "slowquery"]
  security_group_use_name_prefix  = false

  # db_cluster_parameter_group
  create_db_cluster_parameter_group      = true
  db_cluster_parameter_group_name        = local.db1_cluster_parameter_group_name
  db_cluster_parameter_group_family      = "aurora-mysql5.7"
  db_cluster_parameter_group_description = "Splashtop Customized cluster parameter group"
  db_cluster_parameter_group_parameters  = var.db1_cluster_parameters

  # db_parameter_group
  create_db_parameter_group      = true
  db_parameter_group_name        = local.db1_parameter_group_name
  db_parameter_group_family      = "aurora-mysql5.7"
  db_parameter_group_description = "Splashtop Customized DB parameter group"
  db_parameter_group_parameters  = var.db1_db_parameters



  tags = local.tags
}

module "db2" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "7.3.0"

  create_cluster = var.db2_enable
  name           = local.db2_identifier

  engine         = "aurora-mysql"
  engine_version = "5.7"
  instance_class = var.instance_class
  instances = {
    one = {}
    two = {}
  }
  # https://github.com/terraform-aws-modules/terraform-aws-rds-aurora#cluster-instance-configuration
  #
  # Writer: 1
  # Reader(s):
  # At least 2 readers (1 created directly, 1 created by appautoscaling)
  # At most 6 reader instances (1 created directly, 5 created by appautoscaling)
  # autoscaling_enabled      = true
  # autoscaling_min_capacity = 1
  # autoscaling_max_capacity = 5

  vpc_id  = var.vpc_db_vpc_id != "" ? var.vpc_db_vpc_id : data.aws_vpc.stp-vpc-db.id
  subnets = length(var.vpc-db-all-subnets) != 0 ? var.vpc-db-all-subnets : data.aws_subnets.stp-vpc-db-all.ids

  create_db_subnet_group = true
  create_security_group  = true
  allowed_cidr_blocks    = var.allowed_cidr_blocks
  publicly_accessible    = var.publicly_accessible

  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  master_username                     = var.master_username
  master_password                     = random_password.master.result
  create_random_password              = false

  apply_immediately   = true
  skip_final_snapshot = true
  monitoring_interval = var.monitoring_interval
  storage_encrypted   = var.storage_encrypted

  deletion_protection          = var.deletion_protection
  backup_retention_period      = var.backup_retention_period
  preferred_backup_window      = var.preferred_backup_window
  preferred_maintenance_window = var.preferred_maintenance_window
  auto_minor_version_upgrade   = var.auto_minor_version_upgrade

  enabled_cloudwatch_logs_exports = ["slowquery"] #["audit", "error", "general", "slowquery"]
  security_group_use_name_prefix  = false

  # db_cluster_parameter_group
  create_db_cluster_parameter_group      = true
  db_cluster_parameter_group_name        = local.db2_cluster_parameter_group_name
  db_cluster_parameter_group_family      = "aurora-mysql5.7"
  db_cluster_parameter_group_description = "Splashtop Customized cluster parameter group"
  db_cluster_parameter_group_parameters  = var.db2_cluster_parameters

  # db_parameter_group
  create_db_parameter_group      = true
  db_parameter_group_name        = local.db2_parameter_group_name
  db_parameter_group_family      = "aurora-mysql5.7"
  db_parameter_group_description = "Splashtop Customized DB parameter group"
  db_parameter_group_parameters  = var.db2_db_parameters

  tags = local.tags
}