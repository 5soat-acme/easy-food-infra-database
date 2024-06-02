output "master_password" {
  value = aws_rds_cluster.aurora-cluster-pedido.master_password
}

output "endpoint" {
  value = aws_rds_cluster.aurora-cluster-pedido.endpoint
}

output "master_username" {
  value = aws_rds_cluster.aurora-cluster-pedido.master_username
}

output "database_name" {
  value = aws_rds_cluster.aurora-cluster-pedido.database_name
}