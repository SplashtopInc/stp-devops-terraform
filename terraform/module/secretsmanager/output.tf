output "secretsmanager_secret_name" {
  description = "secrets manager for stored secret"
  value       = local.secretsmanager_name
}