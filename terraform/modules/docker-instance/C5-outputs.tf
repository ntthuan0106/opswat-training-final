output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "ec2_instance_ip" {
  value = aws_instance.ec2_instance.public_ip
}