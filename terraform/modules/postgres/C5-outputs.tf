output "aws_kms_arn" {
  value = aws_kms_key.kms_key.arn
}
output "rds_host" {
  value = aws_db_instance.default.address
}
output "kms_key_id" {
  value = aws_kms_key.kms_key.id
}
output "PG_DSN_URL" {
  value = "host=${aws_db_instance.default.endpoint} user=${aws_db_instance.default.username} password=${jsondecode(data.aws_secretsmanager_secret_version.rds_secret.secret_string).password} dbname=${aws_db_instance.default.db_name} sslmode=disable"
  sensitive = true
}
output "PG_URL" {
  description = "PostgreSQL DSN URL"
  value = format(
    "postgres://%s:%s@%s:%d/%s",
    aws_db_instance.default.username,
    jsondecode(data.aws_secretsmanager_secret_version.rds_secret.secret_string).password,
    aws_db_instance.default.endpoint,
    aws_db_instance.default.port,
    aws_db_instance.default.db_name
  )
  sensitive = true
}

# data "aws_db_instance" "postgres_instance" {
#   db_instance_identifier = var.identifier
# }
data "aws_secretsmanager_secret_version" "rds_secret" {
  secret_id = aws_db_instance.default.master_user_secret[0].secret_arn
}