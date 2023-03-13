## add logging
resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/${var.company}-${var.env}-lambda-${var.label}-01"
  retention_in_days = var.cloudwatch_logs_retention_in_days
  kms_key_id        = var.cloudwatch_logs_kms_key_id

  tags = var.tags
}

