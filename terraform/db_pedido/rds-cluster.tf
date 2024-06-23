resource "aws_rds_cluster" "aurora-cluster-pedido" {
  cluster_identifier     = "${var.projectName}-pedido"
  engine                 = "aurora-postgresql"
  engine_version         = "15.4"
  availability_zones     = ["${var.availabilityZoneA}", "${var.availabilityZoneB}"]
  database_name          = "easy_food_pedido"
  master_username        = "postgres"
  master_password        = var.password
  deletion_protection    = false
  skip_final_snapshot    = true
  vpc_security_group_ids = [var.aurora_sg_id]
}