# Definição do provider AWS
provider "aws" {
  region = "us-east-1"
}

/*resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "easy-food-db-subnets"
  subnet_ids = var.subnets_id
}*/


resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier     = "easy-food-db"
  engine                 = "aurora-postgresql"
  engine_version         = "15.4"
  availability_zones     = var.availability_zones
  database_name          = "easy_food"
  master_username        = "postgres"
  master_password        = "acmeacme"
  deletion_protection    = false
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.aurora_sg.id]
}

resource "aws_rds_cluster_instance" "aurora_instance" {
  count                        = 1
  identifier                   = "easy-food-db-instance-${count.index}"
  cluster_identifier           = aws_rds_cluster.aurora_cluster.id
  instance_class               = "db.t3.medium"
  engine                       = aws_rds_cluster.aurora_cluster.engine
  performance_insights_enabled = false
  monitoring_interval          = 0
  #publicly_accessible          = true
}

# Criando um grupo de segurança para o RDS
resource "aws_security_group" "aurora_sg" {
  name   = "rds_aurora_sg"
  vpc_id = var.vpc_id

  // Regra de entrada
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.vpc_cidr_blocks
  }

  // Regra de saída
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.vpc_cidr_blocks
  }

  tags = {
    Name = "rds_aurora_sg"
  }
}

####################
### EC2 Bastion para aplicar script inicial na base de dados ###
####################
# Criando um grupo de segurança para permitir SSH no bastion
resource "aws_security_group" "bastion_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP to EC2"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "key_bastion" {
  key_name   = "easy-food-bastion"
  public_key = file("./ssh_bastion/easy-food-bastion.pub")
}

# Criando uma instância EC2 para servir como bastion
resource "aws_instance" "bastion" {
  ami                         = "ami-051f8a213df8bc089" # AMI desejada
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.key_bastion.key_name
  security_groups             = [aws_security_group.bastion_sg.name]
  associate_public_ip_address = true

  tags = {
    Name = "bastion_rds"
  }
}

resource "null_resource" "aplica_script_database" {
  depends_on = [aws_rds_cluster.aurora_cluster, aws_rds_cluster_instance.aurora_instance, aws_instance.bastion]

  provisioner "local-exec" {
    command = <<EOT
      chmod 400 ./ssh_bastion/easy-food-bastion.pem &&
      ssh -o StrictHostKeyChecking=no -i ./ssh_bastion/easy-food-bastion.pem ec2-user@${aws_instance.bastion.public_ip} "sudo dnf -y install postgresql15" &&
      scp -i ./ssh_bastion/easy-food-bastion.pem ../scripts/init_script.sql ec2-user@${aws_instance.bastion.public_ip}:/tmp &&
      ssh -o StrictHostKeyChecking=no -i ./ssh_bastion/easy-food-bastion.pem ec2-user@${aws_instance.bastion.public_ip} "PGPASSWORD=${aws_rds_cluster.aurora_cluster.master_password} psql -h ${aws_rds_cluster.aurora_cluster.endpoint} -U ${aws_rds_cluster.aurora_cluster.master_username} -d ${aws_rds_cluster.aurora_cluster.database_name} -f /tmp/init_script.sql"
    EOT
  }
}

# Recurso null_resource para encerrar a instância bastion após a execução do script
resource "null_resource" "encerra_bation" {
  depends_on = [null_resource.aplica_script_database]

  provisioner "local-exec" {
    command = "aws ec2 terminate-instances --instance-ids ${aws_instance.bastion.id}"
  }
}