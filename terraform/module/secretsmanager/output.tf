output "secretsmanager_secret_name" {
  description = "secrets manager for stored secret"
  value       = local.secretsmanager_name
}

output "github_user_token" {
  description = "gh_token secret value"
  value       = jsondecode(data.aws_secretsmanager_secret_version.this.secret_string)["${var.secret_key}"]
  sensitive   = true
}
