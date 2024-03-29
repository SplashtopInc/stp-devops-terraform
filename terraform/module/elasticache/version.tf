terraform {
  required_version = ">= 1.1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.24.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
}