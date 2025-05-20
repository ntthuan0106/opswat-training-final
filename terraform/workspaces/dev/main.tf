module "dev_instance" {
  source = "../../modules/docker-instance"
  instance_name = "docker-1"
  vpc_name = "dev"
  region = "us-east-1"
  key_pair_name = "thuan-dev"
  private_key_file_name = "openssh_private_key"
  instance_type = "t3.medium"
  s3_bucket_name = "thuan-opswat-test"
  DOCKER_USERNAME = var.DOCKER_USERNAME
  DOCKER_PASSWORD = var.DOCKER_PASSWORD
  env = "dev"
}


