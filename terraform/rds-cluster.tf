resource "aws_rds_cluster" "aurora-cluster" {
  cluster_identifier     = var.projectName
  engine                 = "aurora-postgresql"
  engine_version         = "15.4"
  availability_zones     = ["${var.availabilityZoneA}", "${var.availabilityZoneB}"]
  database_name          = "easy_food"
  master_username        = "postgres"
  master_password        = var.password
  deletion_protection    = false
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.aurora-sg.id]
}