variable "user_pool_name" {
  description = "Nome do Cognito User Pool"
  type        = string
  default     = "lanchonete-user-pool"
}

variable "password_min_length" {
  description = "Comprimento mínimo da senha"
  type        = number
  default     = 8
}
