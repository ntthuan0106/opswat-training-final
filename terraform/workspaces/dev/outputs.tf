output "instance_pub_ip" {
  value = module.dev_instance.ec2_instance_ip
}
output "private_key_openssh" {
  value = module.dev_instance.private_key_openssh
  sensitive = true
}