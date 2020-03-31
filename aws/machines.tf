module "scoreboard" {
  source = "github.com/mrichardson03/terraform-aws-instance.git?ref=v0.0.2"

  key_name = var.key_name

  vpc_id     = module.vpc.vpc_id
  subnet_id  = module.vpc.public_subnet_ids[0]
  private_ip = "10.0.1.6"
  sg_id      = aws_security_group.iac_sec_grp.id

  instance_type = "t2.micro"
  ami           = var.ami

  create_eip = true

  tags = {
    Name        = "scoreboard"
    Environment = "CTF-Scoreboard"
  }
}
