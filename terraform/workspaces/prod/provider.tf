terraform {
  backend "s3" {
    bucket = "thuan-opswat-test"
    region = "us-east-1"
    encrypt = true
    key = "prod/terraform.tfstate"
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.97.0"
    }
  }
}

provider "aws" {
  # Configuration options
}
