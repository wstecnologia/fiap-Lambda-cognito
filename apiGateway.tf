# Criação do API Gateway
resource "aws_api_gateway_rest_api" "wsTechApi" {
  name        = "wsTechAPI"
  description = "API Gateway integrated with Lambda and Cognito"
}

# Recurso do API Gateway (uma rota)
resource "aws_api_gateway_resource" "wsTechApi_resource" {
  rest_api_id = aws_api_gateway_rest_api.wsTechApi.id
  parent_id   = aws_api_gateway_rest_api.wsTechApi.root_resource_id
  path_part   = "wsTechResource"
}

# Método HTTP para o recurso (usando Cognito para autorização)
resource "aws_api_gateway_method" "wsTechApi_method" {
  rest_api_id   = aws_api_gateway_rest_api.wsTechApi.id
  resource_id   = aws_api_gateway_resource.wsTechApi_resource.id
  http_method   = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_auth.id
}

# Autorizador do Cognito no API Gateway
resource "aws_api_gateway_authorizer" "cognito_auth" {
  name          = "CognitoAuth"
  rest_api_id   = aws_api_gateway_rest_api.wsTechApi.id
  type          = "COGNITO_USER_POOLS"
  provider_arns = [aws_cognito_user_pool.user_pool.arn]
}

# Integração do API Gateway com o Lambda
resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id = aws_api_gateway_rest_api.wsTechApi.id
  resource_id = aws_api_gateway_resource.wsTechApi_resource.id
  http_method = aws_api_gateway_method.wsTechApi_method.http_method
  type        = "AWS_PROXY"
  integration_http_method = "POST"
  uri         = aws_lambda_function.wsTechLambda.invoke_arn
}
