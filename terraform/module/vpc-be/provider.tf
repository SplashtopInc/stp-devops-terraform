provider "aws" {
  shared_credentials_files = ["~/.aws/credentials"]
  region                   = var.region
  profile                  = var.profile

  # Only these AWS Account IDs may be operated on by this template
  assume_role {
    role_arn = "%{if var.assume_role != ""}${var.assume_role}%{endif}"
  }
}