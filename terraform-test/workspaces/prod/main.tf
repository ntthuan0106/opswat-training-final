module "postgresql" {
    source = "../../modules/postgres"
    vpc_name = "postgres-vpc"

    db_name = "postgrestest"
    identifier = "postgres-thuan"
    DB_USERNAME = var.DB_USERNAME

    kms_key_alias = "thuan"
    secret_name = "postgres-secret"
    parameter_group_name = "ps"

    publicly_accessible = true
    env = "prod"
}