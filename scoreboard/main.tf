provider "aws" {
  region = var.aws_region
}

##################################################################
# Data sources to get VPC, subnet, security group and AMI details
##################################################################
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_ami" "ctf_scoreboard_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["secops-ctf-scoreboard*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  
  filter {
    name = "owner-alias"

    values = [
      "941782673963",
    ]
  }
  owners = ["941782673963"]
}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3.0"

  name        = "example"
  description = "Security group for CTF Scoreboard"
  vpc_id      = data.aws_vpc.default.id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "all-icmp"]
  egress_rules        = ["all-all"]
}

resource "aws_network_interface" "this" {
  count = 1

  subnet_id = tolist(data.aws_subnet_ids.all.ids)[count.index]
}

module "ec2" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name                        = "SecOps_CTF_Scoreboard"
  ami                         = "${data.aws_ami.ctf_scoreboard_ami.id}"
  instance_type               = "t2.micro"
  subnet_id                   = tolist(data.aws_subnet_ids.all.ids)[0]
  vpc_security_group_ids      = [module.security_group.this_security_group_id]
  associate_public_ip_address = true
  tags = {
    Name        = "scoreboard"
    Terraform = "true"
    Environment = "CTF-Scoreboard"
  }
}

