output "master_password" {
  value = aws_rds_cluster.aurora-cluster-preparoentrega.master_password
}

output "endpoint" {
  value = aws_rds_cluster.aurora-cluster-preparoentrega.endpoint
}

output "master_username" {
  value = aws_rds_cluster.aurora-cluster-preparoentrega.master_username
}

output "database_name" {
  value = aws_rds_cluster.aurora-cluster-preparoentrega.database_name
}