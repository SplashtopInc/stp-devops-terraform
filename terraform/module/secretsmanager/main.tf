################################################################################
# Secret Manager Module
################################################################################

locals {
  secretsmanager_name        = var.secret_name
  secretsmanager_description = var.secret_description
}
#tfsec:ignore:aws-ssm-secret-use-customer-key
resource "aws_secretsmanager_secret" "this" {
  #checkov:skip=CKV_AWS_149: not use KMS key
  #ts:skip=AWS.AKK.DP.HIGH.0012 skip
  #ts:skip=AWS.SecretsManagerSecret.DP.MEDIUM.0036 skip
  name                    = local.secretsmanager_name
  description             = local.secretsmanager_description
  recovery_window_in_days = 7
}

################################################################################
# Secret Manager version
################################################################################

resource "aws_secretsmanager_secret_version" "this" {
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = jsonencode(var.secret_value)
}

################################################################################
# Secret Manager value
################################################################################


data "aws_secretsmanager_secret_version" "this" {
  secret_id  = aws_secretsmanager_secret.this.id
  depends_on = [aws_secretsmanager_secret_version.this]
}