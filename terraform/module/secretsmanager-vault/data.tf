data "aws_secretsmanager_secret" "name" {
  name = var.secretsmanager_secret_name
}