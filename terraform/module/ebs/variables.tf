variable "availability_zone" {
  type        = string
  description = "(Required) The AZ where the EBS volume will exist."
  default     = ""
}

variable "size" {
  type        = number
  description = "The size of the drive in GiBs."
  default     = 20
}

variable "type" {
  type        = string
  description = "The type of EBS volume. Can be standard, gp2, gp3, io1, io2, sc1 or st1"
  default     = "gp2"
}

variable "encrypted" {
  type        = bool
  description = "If true, the disk will be encrypted."
  default     = true
}

variable "kms_key_id" {
  type        = string
  description = "The ARN for the KMS encryption key."
  default     = ""
}

variable "ebs_name" {
  type        = string
  description = "name of ebs"
  default     = "ebs_test"
}

variable "ebs_tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = { "DLM-snapshot" = "true" }
}

variable "eks_instance_name" {
  type        = list(any)
  description = "name of instance"
  default     = []
}