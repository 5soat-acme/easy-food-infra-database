resource "aws_rds_cluster" "aurora-cluster-preparoentrega" {
  cluster_identifier     = "${var.projectName}-preparoentrega"
  engine                 = "aurora-postgresql"
  engine_version         = "15.4"
  availability_zones     = ["${var.availabilityZoneA}", "${var.availabilityZoneB}"]
  database_name          = "easy_food_preparoentrega"
  master_username        = "postgres"
  master_password        = var.password
  deletion_protection    = false
  skip_final_snapshot    = true
  vpc_security_group_ids = [var.aurora_sg_id]
}