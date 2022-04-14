### Site information ###
variable "region" {
  type    = string
  default = ""
}
variable "environment" {
  type    = string
  default = ""
}
variable "project" {
  type    = string
  default = ""
}

variable "owner" {
  type    = string
  default = "user"
}

variable "cluster_name_env" {
  type    = string
  default = ""
}

variable "cluster_name_region" {
  type    = string
  default = ""
}

### Aurora RDS ###
variable "aurora_mysql_family" {
  type    = string
  default = "aurora-mysql5.7"
}
variable "aurora_description" {
  type    = string
  default = "Splashtop Customized"
}
variable "vpc_db_vpc_id" {
  type    = string
  default = ""
}
variable "vpc-db-all-subnets" {
  type    = list(string)
  default = []
}
### Aurora RDS ###
variable "db2_enable" {
  type    = bool
  default = true
}
variable "db_engine_version" {
  type    = string
  default = ""
}
variable "db_master_username" {
  type    = string
  default = "berdsadmin"
}
variable "db_replica_count" {
  type    = number
  default = 2
}
variable "db_instance_type" {
  type    = string
  default = ""
}
variable "db_instance_type_replica" {
  type    = string
  default = ""
}
variable "db_deletion_protection" {
  type    = bool
  default = true
}
variable "db_backup_retention_period" {
  type    = number
  default = 35
}
variable "db_preferred_backup_window" {
  type    = string
  default = ""
}
variable "db_preferred_maintenance_window" {
  type    = string
  default = ""
}
variable "db1_db_parameters" {
  description = "Aurora Cluster DB1 DB Parameter Group settings"
  type = list(object({
    name         = string
    value        = string
    apply_method = string
  }))

  default = []
}
variable "db1_cluster_parameters" {
  description = "Aurora Cluster DB1 Cluster Parameter Group settings"
  type = list(object({
    name         = string
    value        = string
    apply_method = string
  }))

  default = []
}
variable "db2_db_parameters" {
  description = "Aurora Cluster DB2 DB Parameter Group settings"
  type = list(object({
    name         = string
    value        = string
    apply_method = string
  }))

  default = []
}
variable "db2_cluster_parameters" {
  description = "Aurora Cluster DB2 Cluster Parameter Group settings"
  type = list(object({
    name         = string
    value        = string
    apply_method = string
  }))

  default = []
}