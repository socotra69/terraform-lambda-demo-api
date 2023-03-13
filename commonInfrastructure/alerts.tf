locals {
  sns_services = ["cloudwatch.amazonaws.com", "events.amazonaws.com", "sns.amazonaws.com"]
}

data "aws_iam_policy_document" "sns" {
  policy_id = "key-policy-sns"
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
    sid = "Allow services to use the key"
    actions = [
      "kms:GenerateDataKey*",
      "kms:Decrypt"
    ]
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = local.sns_services
    }
    resources = ["*"]

  }

}


resource "aws_kms_key" "sns" {
  description             = "sns KMS key 1"
  deletion_window_in_days = 10
  policy                  = data.aws_iam_policy_document.sns.json
  tags                    = local.tags
}

resource "aws_kms_alias" "sns" {
  name          = "alias/${local.company}-${var.env}-kms-sns"
  target_key_id = aws_kms_key.sns.key_id
}


resource "aws_sns_topic" "monitoring" {
  name              = "${local.company}-${var.env}-topic-monitoring-01"
  kms_master_key_id = aws_kms_key.sns.id

  tags = local.tags
}


## default metrics
resource "aws_cloudwatch_metric_alarm" "lambda" {
  alarm_name        = "${local.company}-${var.env}-alert-lambda-01"
  alarm_description = "Lambdas with errors"

  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  threshold           = "0"
  period              = "60"
  unit                = "Count"

  metric_name = "Errors"
  namespace   = "AWS/Lambda"
  statistic   = "Maximum"

  tags = local.tags

  alarm_actions = [aws_sns_topic.monitoring.arn]
}
