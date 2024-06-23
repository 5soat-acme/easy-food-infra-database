resource "aws_security_group" "aurora-sg" {
  name   = "SG-${var.projectName}-rds-aurora"
  vpc_id = var.vpcId

  // Regra de entrada
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpcCidrBlocks]
  }

  // Regra de saída
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpcCidrBlocks]
  }

  tags = {
    Name = "SG-${var.projectName}-rds-aurora"
  }
}