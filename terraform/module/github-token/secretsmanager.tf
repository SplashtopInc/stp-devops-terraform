data "aws_secretsmanager_secret_version" "github-token" {
  secret_id = var.secret_name
}

output "github-user-token" {
  value     = jsondecode(data.aws_secretsmanager_secret_version.github-token.secret_string)["gh_token"]
  sensitive = true
}
