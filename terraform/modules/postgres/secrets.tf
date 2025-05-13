resource "random_string" "random" {
  length  = 8
  special = false
}

data "aws_kms_key" "kms_key" {
  key_id = "alias/${var.kms_key_alias}"
}
resource "aws_secretsmanager_secret" "db_credentials" {
  name       = "${var.secret_name}-${random_string.random.result}"
  kms_key_id = data.aws_kms_key.kms_key.id
}
resource "aws_secretsmanager_secret_version" "db_credentials_version" {
  secret_id = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
  })
}

