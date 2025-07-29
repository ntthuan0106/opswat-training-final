module "dev_instance" {
  source = "../../modules/docker-instance"
  instance_name = "docker-1"
  vpc_name = "dev"
  region = "us-east-1"
  key_pair_name = "thuan-dev"
  private_key_file_name = "openssh_private_key"
  ami_id = "ami-015927f8ee1bc0293"
  instance_type = "t3.medium"
  s3_bucket_name = "thuan-nguyen"
  DOCKER_USERNAME = var.DOCKER_USERNAME
  DOCKER_PASSWORD = var.DOCKER_PASSWORD
  docker_compose_file_path = "${path.module}/../../../docker/Docker-compose.yaml"
  env = "dev"
}


