# Recurso null_resource para encerrar a instância bastion após a execução do script
resource "null_resource" "encerra-bation" {
  depends_on = [null_resource.aplica-script-database]

  provisioner "local-exec" {
    command = "aws ec2 terminate-instances --instance-ids ${aws_instance.bastion.id}"
  }
}