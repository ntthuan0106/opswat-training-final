terraform {
  # backend "s3" {
  #   bucket = "thuan-devops-training"
  #   region = "us-east-1"
  #   encrypt = true
  #   key = "tf/terraform.tfstate"
  # }
  backend "s3" {
    bucket = "thuan-opswat-test"
    region = "us-east-1"
    encrypt = true
    key = "dev/terraform.tfstate"
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
