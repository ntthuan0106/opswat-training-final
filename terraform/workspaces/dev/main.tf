module "postgresql" {
    source = "../../modules/postgres"
    vpc_name = "postgres-vpc"

    db_name = "postgrestest"
    identifier = "postgres-thuan"
    # DB_USERNAME = var.DB_USERNAME
    DB_USERNAME = "thuannguyen"
    kms_key_alias = "thuan"
    secret_name = "rdsExternalSecrets"
    parameter_group_name = "ps"
    identifier_user = var.identifier_user
    publicly_accessible = true
    env = "dev"
}
module "dev_instance" {
  source = "../../modules/docker-instance"
  instance_name = "docker-1"
  vpc_name = "dev"
  region = "us-east-1"
  key_pair_name = "thuan-dev"
  private_key_file_name = "openssh_private_key"
  instance_type = "t3.medium"
  s3_bucket_name = "thuan-devops-training"
  DOCKER_USERNAME = var.DOCKER_USERNAME
  DOCKER_PASSWORD = var.DOCKER_PASSWORD
  PG_URL = module.postgresql.PG_URL
  PG_DSN_URL = module.postgresql.PG_DSN_URL
  docker_compoes_file_path = "${path.cwd}/../../../docker/Docker-compose.yaml"
  env = "dev"
}


