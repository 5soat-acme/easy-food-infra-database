resource "aws_rds_cluster_instance" "aurora-instance-pedido" {
  count                        = 1
  identifier                   = "${var.projectName}-pedido-db-instance-${count.index}"
  cluster_identifier           = aws_rds_cluster.aurora-cluster-pedido.id
  instance_class               = "db.t3.medium"
  engine                       = aws_rds_cluster.aurora-cluster-pedido.engine
  performance_insights_enabled = false
  monitoring_interval          = 0
}