## create nsg
resource "aws_security_group" "lambda" {
  name = "${var.company}-${var.env}-nsg-lambda-${var.label}-01"

  tags = merge(var.tags, {
    Name = "${var.company}-${var.env}-nsg-lambda-${var.label}-01"
  })

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  description = "Lambda ${var.label} NSG"
  vpc_id      = var.vpc_id

}

## create function
resource "aws_lambda_function" "main" {
  function_name = "${var.company}-${var.env}-lambda-${var.label}-01"

  role        = var.lambda_role
  kms_key_arn = var.lambda_kms

  memory_size   = var.memory_size
  architectures = var.architectures

  package_type = "Image"

  image_uri = var.image_uri

  timeout = var.timeout

  /*
  image_config {
    entry_point       = var.image_config_entry_point
    command           = var.image_config_command
    working_directory = var.image_config_working_directory
  }*/

  
  vpc_config {
    security_group_ids = [aws_security_group.lambda.id]
    subnet_ids         = var.vpc_subnet_ids
  }

  tags = var.tags
}

