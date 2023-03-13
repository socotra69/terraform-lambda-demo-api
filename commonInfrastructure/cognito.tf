resource "aws_cognito_user_pool" "mainpool" {
  name                     = "${local.company}-${var.env}-pool-default-01"
  auto_verified_attributes = ["email"]

  tags = local.tags
}
