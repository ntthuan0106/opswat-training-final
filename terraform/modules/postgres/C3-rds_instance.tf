resource "aws_db_instance" "default" {

  identifier = var.identifier
  
  db_name = var.db_name
  parameter_group_name = aws_db_parameter_group.db_parameter_group.name

  manage_master_user_password   = true
  master_user_secret_kms_key_id = aws_kms_key.kms_key.id
  
  username = var.DB_USERNAME
  
  engine            = var.engine
  engine_version    = var.engine_version
  instance_class    = var.instance_class
  allocated_storage = 10

  db_subnet_group_name = aws_db_subnet_group.db_subnet_gr.id
  publicly_accessible  = var.publicly_accessible

  skip_final_snapshot = true
  multi_az            = false
  vpc_security_group_ids = [ aws_security_group.rds_sg.id ]

  /* tags = {
    "vpc-id" = "${aws_vpc.db_vpc.id}"
  } */
}
resource "aws_db_parameter_group" "db_parameter_group" {
  name   = "${var.identifier}-db-parameter-group"
  family = "${var.engine}${var.engine_version}"

  parameter {
    name  = "rds.force_ssl"
    value = "0"
  }
}