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
    default = 1
    description = "Number public subnets in cluster"
    validation {
      condition = var.amount_of_pub_subnet >=1
      error_message = "Specify at list 1 public subnet"
    }
}
variable "region"{
    type = string
    description = "EKS located region"
}
variable "env" {
  type = string
  description = "Env tag"
}
variable "ami_id" {
  type = string
  description = "Instance ami id"
  default = "ami-0f88e80871fd81e91"
}
variable "instance_name" {
  type = string
  description = "Instance name"
}
variable "key_pair_name" {
  type = string
}
variable "associate_public_ip_address" {
  type = bool
  default = true
}