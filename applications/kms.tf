data "aws_iam_policy_document" "cloudwatch" {
  policy_id = "key-policy-cloudwatch"
  statement {
    sid = "Enable IAM User Permissions"
    actions = [
      "kms:*",
    ]
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        format(
          "arn:%s:iam::%s:root",
          data.aws_partition.current.partition,
          data.aws_caller_identity.current.account_id
        )
      ]
    }
    resources = ["*"]
  }
  statement {
    sid = "AllowCloudWatchLogs"
    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*"
    ]
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        format(
          "logs.%s.amazonaws.com",
          data.aws_region.current.name
        )
      ]
    }
    resources = ["*"]
  }
}

resource "aws_kms_key" "lambda" {
  description             = "lambda KMS key"
  deletion_window_in_days = 10

  tags = local.tags
}

resource "aws_kms_alias" "lambda" {
  name          = "alias/${local.company}-${var.env}-kms-lambda"
  target_key_id = aws_kms_key.lambda.key_id
}


resource "aws_kms_key" "cloudwatch" {
  description             = "cloudwatch KMS key 1"
  deletion_window_in_days = 10
  policy                  = data.aws_iam_policy_document.cloudwatch.json
  tags                    = local.tags
}

resource "aws_kms_alias" "cloudwatch" {
  name          = "alias/${local.company}-${var.env}-kms-logging"
  target_key_id = aws_kms_key.cloudwatch.key_id
}
