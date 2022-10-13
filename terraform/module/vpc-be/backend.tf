terraform {
  backend "s3" {
    bucket  = "${var.account_name}-${var.short_region}-${var.environment}-${var.project}-terraform-state"
    key     = "${var.account_name}/${var.environment}/${var.region}/${var.project}/${basename(abspath(path.module))}/terraform.tfstate"
    region  = var.region
    encrypt = true
  }
}

