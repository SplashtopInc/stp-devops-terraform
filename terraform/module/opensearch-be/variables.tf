

### ElasticSearch ###
variable "be_elasticsearch_is_production" {
  description = "Set OpenSearch to production"
  type        = bool
  default     = true
}
variable "be_elasticsearch_version" {
  description = "OpenSearch version"
  type        = string
  default     = "OpenSearch_1.1"
}
variable "be_elasticsearch_master_user_name" {
  description = "Master user name of OpenSearch"
  type        = string
  validation {
    condition     = can(regex(".{1,}", var.be_elasticsearch_master_user_name))
    error_message = "Master user name for OpenSearch cannot be EMPTY!"
  }
}
variable "be_elasticsearch_nonprod_master_user_password" {
  description = "Password of NON-PRODUCTION OpenSearch master user"
  type        = string
  sensitive   = true
  validation {
    condition     = can(regex(".[^!&#$^<>-]{8,}", var.be_elasticsearch_nonprod_master_user_password))
    error_message = "Password for NON-PRODUCTION OpenSearch master user cannot be EMPTY, and should be 8 or more characters except '!&#$^<>-'!"
  }
}
variable "be_elasticsearch_create_role" {
  description = "Create Service Linked Role for OpenSearch"
  type        = bool
  default     = true
}
variable "be_elasticsearch_instance_count" {
  description = "Instance count of OpenSearch cluster"
  type        = number
  default     = 2
}
variable "be_elasticsearch_instance_type" {
  description = "Instance type of OpenSearch cluster"
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
  description = "Multi-AZ of OpenSearch cluster"
  type        = bool
  default     = true
}
variable "be_elasticsearch_az_count" {
  description = "AZ count of OpenSearch cluster, only allow 2 or 3"
  type        = number
  default     = 2
}
variable "be_elasticsearch_volume_size" {
  description = "Volume size of OpenSearch cluster in GB"
  type        = number
  default     = 10
}
variable "be_elasticsearch_log_retention" {
  description = "Log retention of OpenSearch cluster"
  type        = number
  default     = 30
}

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

variable "short_region" {
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

variable "domain" {
  type    = string
  default = "splashtop.eu"
}