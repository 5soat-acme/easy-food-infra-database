# Cria uma instância EC2 para servir como bastion
resource "aws_instance" "bastion" {
  ami                         = "ami-051f8a213df8bc089"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.key-bastion.key_name
  security_groups             = [aws_security_group.bastion-sg.name]
  associate_public_ip_address = true

  tags = {
    Name = "${var.projectName}-bastion-rds"
  }
}