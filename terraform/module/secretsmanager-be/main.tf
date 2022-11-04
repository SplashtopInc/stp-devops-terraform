resource "aws_secretsmanager_secret_version" "this" {
  secret_id     = data.aws_secretsmanager_secret.name.id
  secret_string = jsonencode(local.secretsmanager_json)
}