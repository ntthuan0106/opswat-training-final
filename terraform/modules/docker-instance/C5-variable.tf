# Secrets
variable "key_pair_name" {
  type = string
}
variable "private_key_file_name" {
  type = string
}
# variable "private_key_path" {
#   type = string
# }
# Network
variable "region" {
  type = string
}
variable "vpc_name" {
  type = string
}
variable "vpc_cidr_block" {
  type = string
  default = "172.16.0.0/16"
}
variable "associate_public_ip_address" {
  type = bool
  default = true
}
variable "map_public_ip_on_launch" {
  type = bool
  default = true
}
variable "subnet_az" {
  type = string
  default = "ap-southeast-1a"
}

# Instance
variable "instance_name" {
  type = string
}
variable "ami_id" {
  type = string
}
variable "instance_type" {
  type = string
  default = "t3.micro"
}
# Docker hub
variable "DOCKER_USERNAME" {
  type = string
}
variable "DOCKER_PASSWORD" {
  type = string
  sensitive = true
}
# Instance environment variables
variable "PG_URL" {
  type = string
}
variable "PG_DSN_URL" {
  type = string
}
# S3 Bucket
variable "s3_bucket_name" {
  type = string
}

# Tags
variable "env" {
  type = string
}

<<<<<<< HEAD
variable "docker_compoes_file_path" {
  type = string
=======
variable "docker_compose_file_path" {
>>>>>>> test
}