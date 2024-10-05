# Criação do User Pool do Cognito
resource "aws_cognito_user_pool" "user_pool" {
  name = "MyUserPool"

  # Configuração da política de senha
  password_policy {
    minimum_length    = 10
    require_lowercase = true
    require_uppercase = true
    require_numbers   = true
    require_symbols   = true
  }

  # Configurações de atributos para login com e-mail
  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]
}

# Cliente do Cognito (App Client) que se conectará ao pool de usuários
resource "aws_cognito_user_pool_client" "user_pool_client" {
  name         = "wsTechUserPoolClient"
  user_pool_id = aws_cognito_user_pool.user_pool.id
  generate_secret = false
}

# Criação do grupo de usuários 'Administradores'
resource "aws_cognito_user_group" "admin_group" {
  user_pool_id = aws_cognito_user_pool.user_pool.id
  name         = "Administrators"
  description  = "Group for admin users"
}
