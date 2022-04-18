# AWS privilege
variable "profile" {
  type    = string
  default = ""
}
variable "assume_role" {
  type    = string
  default = ""
}

variable "region" {
  type    = string
  default = ""
}

variable "project" {
  type    = string
  default = ""
}

variable "environment" {
  type    = string
  default = ""
}
## custom redis var

variable "vpc_db_vpc_id" {
  description = "vpc module outputs the ID under the name vpc_id"
  type    = string
  default = ""
}

variable "vpc-db-private-subnets" {
  description = "vpc module outputs the db-private-subnet ID under the name subnets"
  type    = list(string)
  default = []
}

variable "redis-sg-cidr" { 
  type = list(string)
  default = [
    "10.0.0.0/8",
    "172.16.0.0/12",
    "192.168.0.0/16"
  ]
}

### ElastiCache ###
# Redis
variable "redis_nodes_list" {
  description = "Redis nodes list"
  type        = list(string)
  default     = [
    "redis-master",
    "redis-noaof",
    "redis-timeout",
    "redis-websocket"
  ]
}

variable "redis_para_notify_keyspace_events_list" {
  description = "Parameter Group - notify-keyspace-events"
  type        = list(string)
  default = [
    "",
    "",
    "xE",
    ""
  ]
}
variable "redis_para_timeout_list" {
  description = "Parameter Group - timeout"
  type        = list(string)
  default = [
    "600",
    "600",
    "600",
    "600"
  ]
}
variable "redis_node_type" {
  type    = string
  default = "cache.t3.medium"
}
variable "redis_failover" { # EC-Redis Auto-failover, true for production, false for others
  type    = bool
  default = true
}
variable "redis_multiaz" { # EC-Redis Multi-AZ, true for production, false for others
  type    = bool
  default = true
}
variable "redis_num_cache_nodes" { # EC-Redis replica number, should be 2 when Multi-AZ is true or 1 for false
  type    = number
  default = 2
}
variable "redis_engine_ver" {
  type    = string
  default = "6.x"
}
variable "redis_snapshot_retention_limit" {
  type    = number
  default = 1
}
variable "redis_parameter_group_family" {
  type    = string
  default = "redis6.x"
}
variable "redis_maintenance_window" {
  description = "Maintenance window to each Redis nodes"
  type        = list(string)
  default = [
    "mon:01:00-mon:02:00",
    "tue:01:00-tue:02:00",
    "wed:02:00-wed:03:00",
    "thu:03:00-thu:04:00"
  ]
}
variable "redis_snapshot_window" {
  description = "Snapshot window to each Redis nodes"
  type        = list(string)
  default = [
    "00:00-01:00",
    "23:00-00:00",
    "01:00-02:00",
    "02:00-03:00"
  ]
}
variable "redis_sns_arn" {
  type    = string
  default = ""
}
