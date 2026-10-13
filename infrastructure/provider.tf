terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket = "fider-remote-backup-019141479033-eu-west-1-an"
    key = "terraform.tfstate"
    region = "eu-west-1"
    
  }
}

# Configure the AWS Provider
provider "aws" {
}