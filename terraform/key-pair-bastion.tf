resource "aws_key_pair" "key-bastion" {
  key_name   = "${var.projectName}-bastion"
  public_key = file("./ssh_bastion/easy-food-bastion.pub")
}