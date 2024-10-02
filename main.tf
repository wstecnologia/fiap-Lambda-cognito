provider "aws" {
  region = "us-east-1"
}

module "cognito" {
  source = "./cognito"
}

module "lambda" {
  source = "./lambda"
  user_pool_id        = module.cognito.user_pool_id
  user_pool_client_id = module.cognito.user_pool_client_id
}

output "cognito_user_pool_id" {
  value = module.cognito.user_pool_id
}

output "lambda_function_arn" {
  value = module.lambda.lambda_function_arn
}
