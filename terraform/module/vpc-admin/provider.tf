provider "aws" {
  region = var.region

  # Only these AWS Account IDs may be operated on by this template
  assume_role {
    role_arn = var.assume_role
  }
}