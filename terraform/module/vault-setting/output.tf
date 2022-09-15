output "vault" {
  value = {
    "auth_path"             = local.vault_k8s_auth_path
    "role_name"             = local.vault_k8s_role_name
    "policy_name"           = local.vault_policy_name
    "secret_data_path"      = "${var.environment}/data/${var.aws_account}/${var.cluster_id}/${var.vault_project}"
    "secret_path"           = local.vault_secret_path
    "secret_name"           = "${var.vault_project}-env"
    "vault_kubernetes_host" = var.vault_k8s_auth_host
  }
}

output "kubernetes_host" {
  value = var.vault_k8s_auth_host
}

output "kubernetes_ca_cert" {
  value = var.vault_k8s_ca
}

output "vault_k8s_auth_jwt" {
  sensitive = true
  value     = local.vault_k8s_auth_jwt
}