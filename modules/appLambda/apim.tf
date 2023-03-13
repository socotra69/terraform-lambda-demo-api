resource "aws_apigatewayv2_api" "main" {
  name          = "${var.company}-${var.env}-apim-${var.label}-01"
  protocol_type = "HTTP"

  tags = var.tags
}

## add lambda to api gateway
resource "aws_apigatewayv2_integration" "main" {
  api_id = aws_apigatewayv2_api.main.id

  description = "Lambda ${var.label}"

  integration_method = "POST"
  integration_type   = "AWS_PROXY"
  integration_uri    = aws_lambda_function.main.invoke_arn


  request_parameters = {
    "overwrite:path" = "$request.path"
  }

  payload_format_version = "2.0"

}

resource "aws_lambda_permission" "allow_apim" {
  statement_id  = "AllowExecutionFromAPIM"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.main.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.main.execution_arn}/*/*"
}

resource "aws_cognito_user_pool_client" "mainpool" {
  name                          = "${var.company}-${var.env}-poolclient-${var.label}-01"
  prevent_user_existence_errors = "ENABLED"
  enable_token_revocation       = true
  // add USER_PASSWORD_AUTH for the sake of the tests
  explicit_auth_flows = ["ALLOW_ADMIN_USER_PASSWORD_AUTH","ALLOW_REFRESH_TOKEN_AUTH"]

  user_pool_id = var.pool_id
}

resource "aws_apigatewayv2_authorizer" "main" {
  name = "${var.company}-${var.env}-authorizer-${var.label}-01"

  api_id           = aws_apigatewayv2_api.main.id
  authorizer_type  = "JWT"
  identity_sources = ["$request.header.Authorization"]


  jwt_configuration {
    issuer   = "https://${var.pool_endpoint}"
    audience = [aws_cognito_user_pool_client.mainpool.id]
  }
}

resource "aws_apigatewayv2_route" "main" {
  api_id             = aws_apigatewayv2_api.main.id
  route_key          = "$default"
  target             = "integrations/${aws_apigatewayv2_integration.main.id}"
  authorization_type = "JWT"
  authorizer_id      = aws_apigatewayv2_authorizer.main.id
}

resource "aws_apigatewayv2_stage" "main" {
  api_id      = aws_apigatewayv2_api.main.id
  name        = "${var.company}-${var.env}-apimstage-${var.label}-01"
  auto_deploy = true
  default_route_settings {
    detailed_metrics_enabled = true
    throttling_burst_limit   = var.throttling_burst_limit
    throttling_rate_limit    = var.throttling_rate_limit
  }

  depends_on = [aws_apigatewayv2_route.main]

}

