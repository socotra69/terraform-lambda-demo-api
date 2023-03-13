output "cognito_endpoint" {
  value = aws_cognito_user_pool.mainpool.endpoint
}

output "vpc_id" {
  value = module.vpcMain.vpc.id
}