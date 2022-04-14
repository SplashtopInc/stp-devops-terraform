provider "aws" {
  shared_credentials_file = "~/.aws/credentials"
  region                  = var.region
  profile                 = var.profile
  assume_role {
    role_arn = "%{if var.assume_role != ""}${var.assume_role}%{endif}"
  }
}