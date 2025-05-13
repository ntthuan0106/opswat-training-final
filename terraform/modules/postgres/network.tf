resource "aws_vpc" "db_vpc" {
  cidr_block = var.vpc_cidr_block

  enable_dns_support   = true
  enable_dns_hostnames = true
  
  tags = {
    Name = var.vpc_name
    env = var.env
  }
}

resource "aws_subnet" "db_subnet_pub" {
  count             = var.amount_of_pub_subnet
  vpc_id            = aws_vpc.db_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 4, count.index)
  availability_zone = local.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name     = "subnet-pub-${count.index}-${local.azs[count.index]}"
    vpc-name = var.vpc_name
    env      = var.env
  }
}

resource "aws_route_table" "route_table_pub" {
  vpc_id = aws_vpc.db_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "${var.identifier}-rt-pub"
    vpc-name = var.vpc_name
    env = var.env
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.db_vpc.id
  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

resource "aws_db_subnet_group" "db_subnet_gr" {
  name = "${var.identifier}-db-subnet-group"
  subnet_ids = aws_subnet.db_subnet_pub[*].id
}

resource "aws_route_table_association" "attach_pub_rt" {
  count = var.amount_of_pub_subnet
  route_table_id = aws_route_table.route_table_pub.id
  subnet_id = aws_subnet.db_subnet_pub[count.index].id
  depends_on = [ aws_subnet.db_subnet_pub ]
}

