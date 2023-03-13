locals {
  company = "demo"
  tags = {
    env  = var.env
    team = "sre"
  }
}


data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_region" "current" {}