module "lambda" {
  source = "../modules/appLambda"

  label     = "test"
  image_uri = "${local.company_ecr}/${var.app}"

  company = local.company
  tags    = local.tags
  env     = var.env

  vpc_id                     = var.vpc_id
  vpc_subnet_ids             = data.aws_subnets.private.ids
  apim_sg                    = data.aws_security_groups.apim_sg.ids[0]
  lambda_role                = aws_iam_role.iam_for_lambda.arn
  lambda_kms                 = aws_kms_key.lambda.arn
  cloudwatch_logs_kms_key_id = aws_kms_key.cloudwatch.arn
  pool_id                    = data.aws_cognito_user_pools.main.ids[0]
  pool_endpoint              = "cognito-idp.${data.aws_region.current.name}.amazonaws.com/${data.aws_cognito_user_pools.main.ids[0]}"
  architectures              = ["x86_64"]
}
