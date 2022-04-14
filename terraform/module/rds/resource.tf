resource "random_string" "suffix" {
  length = 8
  # no upper for RDS related resources naming rule
  upper   = false
  special = false
}