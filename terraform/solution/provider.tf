########################################
# Provider
########################################
terraform {
  required_version = "0.14.3"
  backend "s3" {
    key = ""
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.22.0"
    }
  }
}

provider "aws" {
  region = var.region
}
