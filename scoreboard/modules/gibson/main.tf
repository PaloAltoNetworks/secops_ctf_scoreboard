module "ec2" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name                        = "SecOps_CTF_Gibson"
  ami                         = var.gibson_ami
  instance_type               = var.gibson_instance_type
  subnet_id                   = var.gibson_subnet_id
  vpc_security_group_ids      = var.gibson_vpc_security_group_ids
  associate_public_ip_address = var.gibson_associate_public_ip_address

  tags = {
    Name        = "Gibson"
    Terraform   = "true"
    Environment = "SecOps-CTF"
  }

}
