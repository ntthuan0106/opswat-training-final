# RDS Security Group
resource "aws_security_group" "rds_sg" {
  name        = "${var.identifier}-${var.db_name}-sg"
  description = "Allow PostgreSQL access"
  vpc_id      = aws_vpc.db_vpc.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Replace with your IP range for security
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "RDS"
  }
}