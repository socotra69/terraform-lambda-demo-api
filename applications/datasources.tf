data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  tags = {
    Tier = "Private"
    env  = var.env
  }
}


data "aws_security_groups" "apim_sg" {
  tags = {
    Name = "${local.company}-${var.env}-nsg-apim-01"
    env  = var.env
  }
}

data "aws_cognito_user_pools" "main" {
  name = "${local.company}-${var.env}-pool-default-01"
}
