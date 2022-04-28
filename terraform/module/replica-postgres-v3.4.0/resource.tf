resource "random_string" "suffix" {
  length  = 8
  upper   = false # no upper for RDS related resources naming rule
  special = false
}