provider "aws" {
  region  = "eu-central-1"
}

terraform {
  required_providers {
    aws = {
      version = "~> 4.2"
    }
  }

  required_version = "~> 1.3.7"
}
