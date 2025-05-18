resource "aws_instance" "ec2_instance" {
  ami = var.ami_id
  subnet_id = aws_subnet.subnet.id
  instance_type = var.instance_type
  tags = {
    Name = var.instance_name
    vpc-name = var.vpc_name
    env = var.env
  }
  associate_public_ip_address = var.associate_public_ip_address
  key_name = aws_key_pair.key_pair.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  user_data = file("${path.module}/scripts/install-docker.sh")
}