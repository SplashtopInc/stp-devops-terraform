################################################################################
# Supporting Resources
################################################################################

resource "random_string" "suffix" {
  length = 8
  # no upper for RDS related resources naming rule
  upper   = false
  special = false
}

resource "random_password" "master" {
  length           = var.master_random_password_length
  lower            = true
  upper            = true
  numeric          = true
  special          = false
  override_special = "!&#$^<>-"
}