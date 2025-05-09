resource "aws_rds_cluster" "postgresql" {
  cluster_identifier      = "opswat-training"
  engine                  = "aurora-postgresql"
  availability_zones      = ["us-east-1a", "us-east-1b"]
  database_name           = "mydb"
  master_username = "admin"
  manage_master_user_password = true
}