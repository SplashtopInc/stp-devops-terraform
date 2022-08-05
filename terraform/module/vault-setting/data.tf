data "kubernetes_secret" "vault" {
  metadata {
    name      = var.vault_sa_name
    namespace = var.vault_namespace
  }
}

data "aws_secretsmanager_secret" "name" {
  name = var.secretsmanager_secret_name
}

data "aws_secretsmanager_secret_version" "secret_version" {
  secret_id = data.aws_secretsmanager_secret.name.id
  ## Retrieve Specific Secret Version
  # version_id = "example"
}