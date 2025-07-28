variable "DOCKER_USERNAME" {
  type      = string
}
variable "DOCKER_PASSWORD" {
  type      = string
  sensitive = true
}
variable "identifier_user" {
  type = string
}
