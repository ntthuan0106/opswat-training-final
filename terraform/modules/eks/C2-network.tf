resource "aws_vpc" "eks_vpc" {
  cidr_block = var.eks_cidr_block

  tags = {
    Name = var.vpc_eks_name
    env = var.tag_env
  }
}
# EKS Public network
resource "aws_subnet" "subnet_pub" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = cidrsubnet(var.eks_cidr_block, 4, count.index)
  availability_zone = "${var.region}${element(["a", "b", "c"], count.index)}"
  count             = var.amount_of_pub_subnet
  map_public_ip_on_launch = true
  tags = {
    Name = "${lower(var.cluster_name)}-subnet-pub-${count.index}"
    env = var.tag_env
  }
}
resource "aws_route_table" "route_table_pub" {
  vpc_id = aws_vpc.eks_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.public_interner_gateway.id
  }
  tags = {
    Name = "${lower(var.cluster_name)}-rt-pub"
    env = var.tag_env
  }
}
resource "aws_route_table_association" "attach_pub_rt" {
  count = var.amount_of_pub_subnet
  route_table_id = aws_route_table.route_table_pub.id
  subnet_id = aws_subnet.subnet_pub[count.index].id
  depends_on = [ aws_subnet.subnet_pub ]
}

resource "aws_internet_gateway" "public_interner_gateway" {
  vpc_id = aws_vpc.eks_vpc.id
  tags = {
    name = "${var.cluster_name}-inet-gateway"
    env = var.tag_env
  }
}
