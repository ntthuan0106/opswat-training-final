# Network
variable "region" {
  type = string
  default = "us-east-1"
}
variable "vpc_cidr_block" {
  type = string
  description = "EkS CIDR block"
  default = "172.16.0.0/16"
}
variable "vpc_name" {
  type = string
  description = "VPC name"
}
variable "amount_of_pub_subnet"{
    type = number
    default = 2
    description = "Number public subnets in cluster"
    validation {
      condition = var.amount_of_pub_subnet >=1
      error_message = "Specify at list 1 public subnet"
    }
}
variable "publicly_accessible" {
  type = bool
  default = false
}
# Tags
variable "env" {
  type = string
  description = "Env tag"
}

# Secrets
variable "kms_key_alias" {
  type = string
  sensitive = true
}

variable "secret_name" {
  type = string
}
variable "DB_USERNAME" {
  type = string
  sensitive = true
}
variable "DB_PASSWORD" {
  type = string
  sensitive = true
}
# RDS
variable "identifier" {
  type = string
}

variable "instance_class" {
  type = string
  default = "db.t3.micro"
}

variable "db_name" {
  type = string
}

variable "engine" {
  type = string
  default = "postgres"
}

variable "engine_version" {
  type = string
  default = "16"
}

variable "parameter_group_name" {
  type = string
}

