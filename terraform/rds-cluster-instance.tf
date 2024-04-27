resource "aws_rds_cluster_instance" "aurora-instance" {
  count                        = 1
  identifier                   = "${var.projectName}-db-instance-${count.index}"
  cluster_identifier           = aws_rds_cluster.aurora-cluster.id
  instance_class               = "db.t3.medium"
  engine                       = aws_rds_cluster.aurora-cluster.engine
  performance_insights_enabled = false
  monitoring_interval          = 0
}