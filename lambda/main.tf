# /infra/lambda/main.tf
resource "aws_lambda_function" "lanchonete_auth_lambda" {
  function_name = var.lambda_function_name
  runtime       = var.lambda_runtime
  handler       = "index.handler"
  role          = aws_iam_role.lambda_exec_role.arn
  filename      = "lambda.zip"

  environment {
    variables = {
      USER_POOL_ID        = var.user_pool_id
      USER_POOL_CLIENT_ID = var.user_pool_client_id
    }
  }
}
