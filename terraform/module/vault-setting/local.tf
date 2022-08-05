locals {
  vault_k8s_auth_path      = "${var.environment}-k8s/${var.aws_account}/${var.cluster_id}/${var.vault_project}"
  vault_k8s_role_name      = "${var.cluster_id}-role-${var.vault_project}"
  vault_k8s_role_sa        = "${var.vault_project}-serviceaccount"
  vault_k8s_role_namespace = var.vault_project
  vault_policy_name        = "${var.cluster_id}-policy-${var.vault_project}"
  vault_secret_path        = "${var.environment}/${var.aws_account}/${var.cluster_id}/${var.vault_project}/${var.vault_project}-env"
  vault_k8s_auth_jwt       = data.kubernetes_secret.vault.data.token
}


locals {
  secretsmanager_json = data.aws_secretsmanager_secret_version.secret_version.secret_string
}