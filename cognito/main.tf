resource "aws_cognito_user_pool" "lanchonete_user_pool" {
  name = "lanchonete-user-pool"
  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_numbers   = true
    require_symbols   = false
    require_uppercase = true
  }
  auto_verified_attributes = ["email"]
}

resource "aws_cognito_user_pool_client" "lanchonete_user_pool_client" {
  name         = "lanchonete-user-pool-client"
  user_pool_id = aws_cognito_user_pool.lanchonete_user_pool.id
  generate_secret = false
  allowed_oauth_flows_user_pool_client = true
}

output "user_pool_id" {
  value = aws_cognito_user_pool.lanchonete_user_pool.id
}

output "user_pool_client_id" {
  value = aws_cognito_user_pool_client.lanchonete_user_pool_client.id
}
