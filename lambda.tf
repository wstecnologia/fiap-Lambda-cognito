# Definição da função Lambda
resource "aws_lambda_function" "wsTechLambda" {
  function_name = "wsTechLambdaFunction"
  handler       = "index.handler"
  runtime       = "nodejs18.x"
  role          = aws_iam_role.lambda_role.arn

  # Referenciando o bucket e o arquivo no S3
  s3_bucket     = aws_s3_bucket.lambda_bucket.bucket
  s3_key        = aws_s3_bucket_object.lambda_zip.key

  # Cálculo do hash do código fonte (para detectar mudanças)
  source_code_hash = filebase64sha256("lambda_function_payload.zip")

  memory_size   = 128
  timeout       = 10
}

# Papel (IAM Role) para permitir que a função Lambda seja executada
resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [{
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      }
    }]
  })
}

# Política de permissões para o Lambda (opcional - caso precise de permissões adicionais)
resource "aws_iam_role_policy" "lambda_policy" {
  name   = "wsTechlambda_policy"
  role   = aws_iam_role.lambda_role.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [{
      "Action": "logs:CreateLogGroup",
      "Effect": "Allow",
      "Resource": "arn:aws:logs:*:*:*"
    }, {
      "Action": [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:logs:*:*:*"
    }]
  })
}
