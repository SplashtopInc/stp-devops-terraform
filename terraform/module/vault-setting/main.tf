#--------------------------------
# Enable kubernetes auth method
#--------------------------------
resource "vault_auth_backend" "kubernetes" {
  type  = "kubernetes"
  path  = local.vault_k8s_auth_path
  tune  = []
  local = false
}
#--------------------------------
# Create kubernetes auth config
#--------------------------------
resource "vault_kubernetes_auth_backend_config" "config" {
  backend                = vault_auth_backend.kubernetes.path
  token_reviewer_jwt     = local.vault_k8s_auth_jwt
  disable_iss_validation = true
  disable_local_ca_jwt   = false
  kubernetes_ca_cert     = var.vault_k8s_ca
  kubernetes_host        = var.vault_k8s_auth_host
  pem_keys               = []
}
#--------------------------------
# Create kubernetes auth role
#--------------------------------
resource "vault_kubernetes_auth_backend_role" "role" {
  backend                          = vault_auth_backend.kubernetes.path
  role_name                        = local.vault_k8s_role_name
  bound_service_account_names      = [local.vault_k8s_role_sa]
  bound_service_account_namespaces = [local.vault_k8s_role_namespace]
  token_ttl                        = var.vault_k8s_role_token_ttl
  token_no_default_policy          = false
  token_policies                   = [local.vault_policy_name]
  token_bound_cidrs                = []
}

#---------------------
# Create policies
#---------------------

# Create admin policy in the root namespace
resource "vault_policy" "K8S_policy" {
  name   = local.vault_policy_name
  policy = <<EOT
path "${var.environment}/data/${var.aws_account}/${var.cluster_id}/${var.vault_project}/*" {
  capabilities = ["read"]
}
EOT
}

#----------------------------------------------------------
# Enable secrets engines
#----------------------------------------------------------

# Enable K/V v2 secrets engine at 'kv-v2'
resource "vault_mount" "kvv2" {
  path                      = var.vault_mount_path
  type                      = var.vault_mount_type
  default_lease_ttl_seconds = 0
  description               = "This is an KV Version 2 secret engine mount"
  options = {
    "version" = "2"
  }
}
# Writes and manages secrets stored in Vault's "generic" secret backend
resource "vault_generic_secret" "env-json" {
  depends_on = [
    vault_mount.kvv2
  ]
  path         = local.vault_secret_path
  disable_read = false
  data_json    = local.secretsmanager_json
}