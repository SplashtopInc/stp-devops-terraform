locals {
  name_region = join("", [substr(replace(var.region, "-", ""), 0, 3), regex("\\d$", var.region)])
  name_suffix = "${local.name_region}-${random_string.suffix.result}"
  name        = "${var.app_name}-postgres-${local.name_suffix}"
  region      = var.region
  tags = {
    Owner       = var.app_name
    Environment = var.environment
  }

  engine                = var.engine
  engine_version        = var.engine_version
  family                = var.family
  major_engine_version  = var.major_engine_version
  instance_class        = var.instance_class
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  port                  = var.port
}