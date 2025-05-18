variable "AWS_ACCESS_KEY_ID" {
  type = string
  sensitive = true
}
variable "AWS_SECRET_ACCESS_KEY" {
  type = string
  sensitive = true
}
variable "DOCKER_EMAIL" {
  type = string
  sensitive = true
}
variable "DOCKER_USERNAME" {
  type = string
}
variable "DOCKER_PASSWORD" {
  type = string
  sensitive = true
}