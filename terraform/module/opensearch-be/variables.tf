### System ###
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

variable "account" {
  type    = string
  default = ""
}
# AWS account name for SQS naming prefix (for temporary)
variable "aws_account_name" {
  type    = string
  default = ""
  # AWS account name e.g., "aws-polkast", "aws-gstun", "aws-rd", "aws-tperd" ...
}

### ElasticSearch ###
variable "be_elasticsearch_create_role" {
  description = "Create Service Linked Role for ElasticSearch"
  type        = bool
  default     = true
}
variable "be_elasticsearch_instance_count" {
  description = "Instance count of ElasticSearch cluster"
  type        = number
  default     = 2
}
variable "be_elasticsearch_instance_type" {
  description = "Instance type of ElasticSearch cluster"
  type        = string
  default     = "r6g.large.search"
}
# https://docs.aws.amazon.com/opensearch-service/latest/developerguide/managedomains-dedicatedmasternodes.html
variable "be_elasticsearch_dedicated_master_enalbed" {
  description = "Enabled Dedicated Master"
  type        = bool
  default     = true
}
# https://docs.aws.amazon.com/opensearch-service/latest/developerguide/limits.html
variable "be_elasticsearch_dedicated_master_count" {
  description = "Dedicated Master count"
  type        = number
  default     = 3
}
# https://aws.amazon.com/opensearch-service/pricing/?nc1=h_ls
variable "be_elasticsearch_dedicated_master_type" {
  description = "Dedicated Master instance type"
  type        = string
  default     = "m6g.large.search"
}
variable "be_elasticsearch_multiaz" {
  description = "Multi-AZ of ElasticSearch cluster"
  type        = bool
  default     = true
}
variable "be_elasticsearch_az_count" {
  description = "AZ count of ElasticSearch cluster, only allow 2 or 3"
  type        = number
  default     = 2
}
variable "be_elasticsearch_volume_size" {
  description = "Volume size of ElasticSearch cluster in GB"
  type        = number
  default     = 10
}
variable "be_elasticsearch_log_retention" {
  description = "Log retention of ElasticSearch cluster"
  type        = number
  default     = 30
}

variable "be_elasticsearch_search_logs_enabled" {
  type    = bool
  default = true
}

variable "be_elasticsearch_index_logs_enabled" {
  type    = bool
  default = true
}

variable "be_elasticsearch_application_logs_enabled" {
  type    = bool
  default = true
}

variable "be_elasticsearch_audit_logs_enabled" {
  type    = bool
  default = true
}