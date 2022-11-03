module "db1" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "7.5.1"

  name = local.db1_identifier

  create_cluster = var.db1_enable
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
  version = "7.5.1"

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

################################################################################
# Secret Manager Module
################################################################################

locals {
  secretsmanager_name        = (var.db1_enable || var.db2_enable) ? "${var.environment}/data/rds/${local.cluster_name_suffix}" : ""
  secretsmanager_description = "Vault secrets for ${local.cluster_name_suffix} aurora-mysql"
  secretsmanager_json = {
    "db1_writer_endpoint" = "${module.db1.cluster_endpoint}",
    "db1_reader_endpoint" = "${module.db1.cluster_reader_endpoint}",
    "db2_writer_endpoint" = "${module.db2.cluster_endpoint}",
    "db2_reader_endpoint" = "${module.db2.cluster_reader_endpoint}",
    "db1_password"        = "${module.db1.cluster_master_password}",
    "db2_password"        = "${module.db2.cluster_master_password}"
  }
}

#tfsec:ignore:aws-ssm-secret-use-customer-key
resource "aws_secretsmanager_secret" "this" {
  #checkov:skip=CKV_AWS_149: not use KMS key
  #ts:skip=AWS.AKK.DP.HIGH.0012 skip
  #ts:skip=AWS.SecretsManagerSecret.DP.MEDIUM.0036 skip
  count                   = (var.db1_enable || var.db2_enable) ? 1 : 0
  name                    = local.secretsmanager_name
  description             = local.secretsmanager_description
  recovery_window_in_days = 7
}

resource "aws_secretsmanager_secret_version" "this" {
  count         = (var.db1_enable || var.db2_enable) ? 1 : 0
  secret_id     = resource.aws_secretsmanager_secret.this[0].id
  secret_string = jsonencode(local.secretsmanager_json)
}