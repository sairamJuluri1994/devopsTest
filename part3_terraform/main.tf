terraform {
  required_version = "~>1.0"
  required_providers {
    aws = "~> 3.48"
  }
}

provider "aws" {
  region = "us-east-2"
}

