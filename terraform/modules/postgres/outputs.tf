output "aws_kms_arn" {
  value = data.aws_kms_key.kms_key.arn
}
output "rds_host" {
  value = aws_db_instance.default.address
}
output "secret_name" {
  value = aws_secretsmanager_secret.db_credentials.name
}