output "lambda_function_arn" {
  description = "ARN da função Lambda"
  value       = aws_lambda_function.lanchonete_auth_lambda.arn
}

output "lambda_function_name" {
  description = "Nome da função Lambda"
  value       = aws_lambda_function.lanchonete_auth_lambda.function_name
}
