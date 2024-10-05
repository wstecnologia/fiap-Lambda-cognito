# Definindo o bucket S3 para armazenar o código da função Lambda
resource "aws_s3_bucket" "lambda_bucket" {
  bucket = "wsTech-bucket-lambda"
}

# Carregando o arquivo zipado da função Lambda para o bucket S3
resource "aws_s3_bucket_object" "lambda_zip" {
  bucket = aws_s3_bucket.lambda_bucket.bucket
  key    = "lambda_function_payload.zip"  # Nome do arquivo no S3
  source = "lambda_function_payload.zip"  # Nome do arquivo local que será enviado
  etag   = filemd5("lambda_function_payload.zip")
}
