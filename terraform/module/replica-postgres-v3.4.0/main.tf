################################################################################
# Supporting Resources
################################################################################

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4"

  name        = local.name
  description = "Replica PostgreSQL example security group"
  vpc_id      = var.vpc_id

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      description = "PostgreSQL access from within VPC"
      cidr_blocks = var.cidr_blocks
    },
  ]

  tags = local.tags
}

################################################################################
# Master DB
################################################################################
#tfsec:ignore:aws-rds-specify-backup-retention:
module "master" {
  source  = "terraform-aws-modules/rds/aws"
  version = "3.4.0"

  identifier = "${local.name}-master"

  engine               = local.engine
  engine_version       = local.engine_version
  family               = local.family
  major_engine_version = local.major_engine_version
  instance_class       = local.instance_class

  allocated_storage     = local.allocated_storage
  max_allocated_storage = local.max_allocated_storage
  storage_encrypted     = var.storage_encrypted
  copy_tags_to_snapshot = true

  performance_insights_enabled = true

  name     = var.db_name
  username = var.db_user

  password = var.db_pass
  port     = local.port

  create_random_password = var.create_random_password

  multi_az               = true
  create_db_subnet_group = false
  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = [module.security_group.security_group_id]

  maintenance_window              = "Mon:00:00-Mon:03:00"
  backup_window                   = "03:00-06:00"
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]

  # Backups are required in order to create a replica
  backup_retention_period = 5
  skip_final_snapshot     = true
  deletion_protection     = var.deletion_protection

  tags = local.tags
}

################################################################################
# Replica DB
################################################################################
#tfsec:ignore:aws-rds-specify-backup-retention:
module "replica" {
  source  = "terraform-aws-modules/rds/aws"
  version = "3.4.0"

  identifier = "${local.name}-replica"

  # Source database. For cross-region use db_instance_arn
  replicate_source_db = module.master.db_instance_id

  engine               = local.engine
  engine_version       = local.engine_version
  family               = local.family
  major_engine_version = local.major_engine_version
  instance_class       = local.instance_class

  allocated_storage     = local.allocated_storage
  max_allocated_storage = local.max_allocated_storage
  storage_encrypted     = var.storage_encrypted
  copy_tags_to_snapshot = false

  performance_insights_enabled = true

  # Username and password should not be set for replicas
  username = null
  password = null
  port     = local.port

  multi_az               = false
  vpc_security_group_ids = [module.security_group.security_group_id]

  maintenance_window              = "Tue:00:00-Tue:03:00"
  backup_window                   = "03:00-06:00"
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]

  backup_retention_period = 0
  skip_final_snapshot     = true
  deletion_protection     = false

  # Not allowed to specify a subnet group for replicas in the same region
  create_db_subnet_group = false

  tags = local.tags
}