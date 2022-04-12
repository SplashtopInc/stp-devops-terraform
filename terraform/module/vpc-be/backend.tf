terraform {
  backend "s3" {
    bucket  = "mybucket"
    key     = "path/to/my/key"
    region  = var.region
    encrypt = true
    profile = var.profile
  }
}
