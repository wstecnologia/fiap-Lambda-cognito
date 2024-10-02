variable "lambda_function_name" {
  description = "Nome da função Lambda"
  type        = string
  default     = "lanchonete_auth"
}

variable "lambda_runtime" {
  description = "Ambiente de execução da Lambda"
  type        = string
  default     = "nodejs16.x"
}

# /infra/lambda/variables.tf
variable "user_pool_id" {
  description = "ID do Cognito User Pool"
  type        = string
}

variable "user_pool_client_id" {
  description = "ID do Cognito User Pool Client"
  type        = string
}
