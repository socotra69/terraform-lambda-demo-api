resource "aws_security_group" "apiGateway" {
  name = "${local.company}-${var.env}-nsg-apim-01"

  tags = merge(local.tags, {
    Name = "${local.company}-${var.env}-nsg-apim-01"
  })

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  description = "API Gateway VPC NSG"
  vpc_id      = module.vpcMain.vpc.id

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_apigatewayv2_vpc_link" "main" {
  name               = "${local.company}-${var.env}-apim-01"
  security_group_ids = [aws_security_group.apiGateway.id]

  subnet_ids = flatten([for sub in module.vpcMain.private_subnets : tolist(sub.*.id)])


  tags = local.tags
}
