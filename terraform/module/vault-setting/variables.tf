### for local var ###
variable "vault_sa_name" {
  type    = string
  default = "vault-serviceaccount"
}

variable "vault_namespace" {
  type    = string
  default = "vault"
}

variable "cluster_id" {
  type    = string
  default = ""
}

variable "vault_project" {
  type    = string
  default = "be-app"
}

variable "environment" {
  type    = string
  default = "test"
}

variable "aws_account" {
  type    = string
  default = "tperd"
}

### auth config###
variable "vault_k8s_auth_jwt" {
  type    = string
  default = "eyJhbGc"
}

variable "vault_k8s_ca" {
  type    = string
  default = ""
}

variable "vault_k8s_auth_host" {
  type    = string
  default = ""
}
### auth role ###
variable "vault_k8s_role_token_ttl" {
  type    = number
  default = 14400
}

### secrets ###
variable "vault_mount_path" {
  type    = string
  default = "test"
}

variable "vault_mount_type" {
  type    = string
  default = "kv"
}

variable "env_json" {
  type    = string
  default = ""
}

### EKS ###
variable "secretsmanager_secret_name" {
  type        = string
  default     = ""
  description = "eks cluster secrets manager secret name"
}