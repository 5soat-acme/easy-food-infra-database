resource "aws_rds_cluster_instance" "aurora-instance-preparoentrega" {
  count                        = 1
  identifier                   = "${var.projectName}-preparoentrega-db-instance-${count.index}"
  cluster_identifier           = aws_rds_cluster.aurora-cluster-preparoentrega.id
  instance_class               = "db.t3.medium"
  engine                       = aws_rds_cluster.aurora-cluster-preparoentrega.engine
  performance_insights_enabled = false
  monitoring_interval          = 0
}