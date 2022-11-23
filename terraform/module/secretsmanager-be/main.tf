resource "aws_secretsmanager_secret_version" "this" {
  count         = data.aws_secretsmanager_secret.name.id ? 1 : 0
  secret_id     = data.aws_secretsmanager_secret.name.id
  secret_string = jsonencode(local.secretsmanager_json)
}