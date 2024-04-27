resource "null_resource" "aplica-script-database" {
  depends_on = [aws_rds_cluster.aurora-cluster, aws_rds_cluster_instance.aurora-instance, aws_instance.bastion]

  provisioner "local-exec" {
    command = <<EOT
      chmod 400 ./ssh_bastion/easy-food-bastion.pem &&
      ssh -o StrictHostKeyChecking=no -i ./ssh_bastion/easy-food-bastion.pem ec2-user@${aws_instance.bastion.public_ip} "sudo dnf -y install postgresql15" &&
      scp -i ./ssh_bastion/easy-food-bastion.pem ../scripts/init_script.sql ec2-user@${aws_instance.bastion.public_ip}:/tmp &&
      ssh -o StrictHostKeyChecking=no -i ./ssh_bastion/easy-food-bastion.pem ec2-user@${aws_instance.bastion.public_ip} "PGPASSWORD=${aws_rds_cluster.aurora-cluster.master_password} psql -h ${aws_rds_cluster.aurora-cluster.endpoint} -U ${aws_rds_cluster.aurora-cluster.master_username} -d ${aws_rds_cluster.aurora-cluster.database_name} -f /tmp/init_script.sql"
    EOT
  }
}