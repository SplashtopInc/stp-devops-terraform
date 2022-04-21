### for DB 1 ###
resource "aws_db_parameter_group" "db1_parameter_group" {
  name        = local.db1_parameter_group_name
  family      = var.aurora_mysql_family
  description = var.aurora_description

  tags = {
    Project     = var.project
    Environment = var.environment
    Owner       = var.owner
  }

  dynamic "parameter" {
    for_each = var.db1_db_parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }
}

resource "aws_rds_cluster_parameter_group" "db1_cluster_parameter_group" {
  name        = local.db1_cluster_parameter_group_name
  family      = var.aurora_mysql_family
  description = var.aurora_description

  tags = {
    Project     = var.project
    Environment = var.environment
    Owner       = var.owner
  }

  dynamic "parameter" {
    for_each = var.db1_cluster_parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }
}

module "db1" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "5.2.0"

  name = local.db1_identifier

  engine         = "aurora-mysql"
  engine_version = var.db_engine_version
  engine_mode    = "provisioned" #  Valid values: global, multimaster, parallelquery, provisioned, serverless. Defaults to: provisioned

  vpc_id  = (var.vpc_db_vpc_id != "" ? var.vpc_db_vpc_id : data.aws_vpc.stp-vpc-db.id)
  subnets = (var.vpc-db-all-subnets != [] ? var.vpc-db-all-subnets : data.aws_subnet_ids.stp-vpc-db-all.ids)

  username = var.db_master_username

  instance_type         = var.db_instance_type
  replica_count         = var.db_replica_count
  instance_type_replica = var.db_instance_type_replica
  deletion_protection   = var.db_deletion_protection
  apply_immediately     = true
  storage_encrypted     = true
  monitoring_interval   = 60 # (seconds, a value in [0, 1, 5, 10, 15, 30, 60])

  backup_retention_period      = var.db_backup_retention_period
  preferred_backup_window      = var.db_preferred_backup_window
  preferred_maintenance_window = var.db_preferred_maintenance_window
  auto_minor_version_upgrade   = false

  enabled_cloudwatch_logs_exports = ["slowquery"]
  allowed_cidr_blocks             = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
  create_security_group           = true
  publicly_accessible             = false

  skip_final_snapshot             = true
  db_parameter_group_name         = aws_db_parameter_group.db1_parameter_group.id
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.db1_cluster_parameter_group.id

  tags = {
    Project     = var.project
    Environment = var.environment
    Owner       = var.owner
  }
}

### for DB 2 ###
resource "aws_db_parameter_group" "db2_parameter_group" {
  name        = local.db2_parameter_group_name
  family      = var.aurora_mysql_family
  description = var.aurora_description

  tags = {
    Project     = var.project
    Environment = var.environment
    Owner       = var.owner
  }

  dynamic "parameter" {
    for_each = var.db2_db_parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }
}

resource "aws_rds_cluster_parameter_group" "db2_cluster_parameter_group" {
  name        = local.db2_cluster_parameter_group_name
  family      = var.aurora_mysql_family
  description = var.aurora_description

  tags = {
    Project     = var.project
    Environment = var.environment
    Owner       = var.owner
  }

  dynamic "parameter" {
    for_each = var.db2_cluster_parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }
}

module "db2" {
  create_cluster = var.db2_enable

  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "5.2.0"

  name = local.db2_identifier

  engine         = "aurora-mysql"
  engine_version = var.db_engine_version
  engine_mode    = "provisioned" #  Valid values: global, multimaster, parallelquery, provisioned, serverless. Defaults to: provisioned

  vpc_id  = (var.vpc_db_vpc_id != "" ? var.vpc_db_vpc_id : data.aws_vpc.stp-vpc-db.id)
  subnets = (var.vpc-db-all-subnets != "" ? var.vpc-db-all-subnets : data.aws_subnet_ids.stp-vpc-db-all.ids)

  username = var.db_master_username

  instance_type         = var.db_instance_type
  replica_count         = var.db_replica_count
  instance_type_replica = var.db_instance_type_replica
  deletion_protection   = var.db_deletion_protection
  apply_immediately     = true
  storage_encrypted     = true
  monitoring_interval   = 60 # (seconds, a value in [0, 1, 5, 10, 15, 30, 60])

  backup_retention_period      = var.db_backup_retention_period
  preferred_backup_window      = var.db_preferred_backup_window
  preferred_maintenance_window = var.db_preferred_maintenance_window
  auto_minor_version_upgrade   = false

  enabled_cloudwatch_logs_exports = ["slowquery"]
  allowed_cidr_blocks             = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
  create_security_group           = true
  publicly_accessible             = false

  skip_final_snapshot             = true
  db_parameter_group_name         = aws_db_parameter_group.db2_parameter_group.id
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.db2_cluster_parameter_group.id

  tags = {
    Project     = var.project
    Environment = var.environment
    Owner       = var.owner
  }
}