resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    name = var.vpc_name
    Env = var.env
  }
}
# EKS Public network
resource "aws_subnet" "subnet_pub" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 4, count.index)
  availability_zone = "${var.region}${element(["a", "b", "c"], count.index)}"
  count             = var.amount_of_pub_subnet
  tags = {
    name = "subnet-pub-${count.index}"
    vpc-name = var.vpc_name
    env = var.env
  }
}
resource "aws_route_table" "route_table_pub" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "rt-pub"
    vpc-name = var.vpc_name
    env = var.env
  }
}
resource "aws_route_table_association" "attach_pub_rt" {
  count = var.amount_of_pub_subnet
  route_table_id = aws_route_table.route_table_pub.id
  subnet_id = aws_subnet.subnet_pub[count.index].id
  depends_on = [ aws_subnet.subnet_pub ]
}
resource "aws_route_table_association" "attach_igw" {
  route_table_id = aws_route_table.route_table_pub.id
  gateway_id = aws_internet_gateway.gw.id
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
}
data "aws_key_pair" "key_pair" {
  key_name   = var.key_pair_name
  include_public_key = true
}

resource "aws_security_group" "allow_ssh" {
  name_prefix = "allow_ssh"
  vpc_id = aws_vpc.vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "ec2_instance" {
  ami = var.ami_id
  subnet_id = aws_subnet.subnet_pub[0].id
  instance_type = "t3.micro"
  tags = {
    name = var.instance_name
    vpc-name = var.vpc_name
    env = var.env
  }
  associate_public_ip_address = var.associate_public_ip_address
  key_name = data.aws_key_pair.key_pair.key_name
  security_groups = [ aws_security_group.allow_ssh.id ]
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras install docker -y
              sudo service docker start
              sudo usermod -a -G docker ec2-user
              sudo chkconfig docker on
              EOF
    
}

