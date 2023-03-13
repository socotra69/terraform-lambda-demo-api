## Create a role for the lambda service
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "lambda_logging" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["arn:aws:logs:*:*:*"]
  }
}

resource "aws_iam_policy" "lambda_logging" {
  name        = "${local.company}-${var.env}-pol-lambda-logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"
  policy      = data.aws_iam_policy_document.lambda_logging.json
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

data "aws_iam_policy_document" "lambda_network" {
  statement {
    effect = "Allow"

    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "lambda_network" {
  name        = "${local.company}-${var.env}-pol-lambda-network"
  path        = "/"
  description = "IAM policy for  lambda networking"
  policy      = data.aws_iam_policy_document.lambda_network.json
}

resource "aws_iam_role_policy_attachment" "lambda_network" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_network.arn
}


data "aws_iam_policy_document" "lambda_kms" {   
  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      aws_kms_key.lambda.arn,
    ]
  }
}

resource "aws_iam_policy" "lambda_kms" {
  name        = "${local.company}-${var.env}-pol-lambda-kms"
  path        = "/"
  description = "IAM policy for  lambda kms"
  policy      = data.aws_iam_policy_document.lambda_kms.json
}

resource "aws_iam_role_policy_attachment" "lambda_kms" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_kms.arn
}


resource "aws_iam_role" "iam_for_lambda" {
  name               = "${local.company}-${var.env}-rol-lambda-default-1"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  tags = local.tags
}
