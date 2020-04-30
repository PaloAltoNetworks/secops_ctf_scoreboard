provider "aws" {
  region = var.aws_region
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

  owners = ["603651300939"]
}

module "vpc" {
  source = "github.com/mrichardson03/terraform-aws-vpc?ref=v0.0.3"

  cidr_block = var.vpc_cidr
  azs        = [var.availability_zone]

  mgmt_subnet_cidrs    = [var.mgmt_subnet_cidr]
  public_subnet_cidrs  = [var.public_subnet_cidr]
  private_subnet_cidrs = [var.private_subnet_cidr]

  tags = {
    Name        = "CTF-VPC"
    Environment = "CTF-Scoreboard"
  }
}

resource "aws_route_table" "private" {
  vpc_id = module.vpc.vpc_id

  route {
    cidr_block           = "0.0.0.0/0"
    network_interface_id = module.firewall.eth2_interface_id
  }

  tags = {
    Name        = "CTF-VPC-PrivateRouteTable"
    Environment = "CTF-Scoreboard"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = module.vpc.private_subnet_ids[0]
  route_table_id = aws_route_table.private.id
}

module "fw_bootstrap" {
  source  = "stealthllama/panos-bootstrap/aws"
  version = "v0.1.1"

  hostname = "ctf-firewall"
}

module "firewall" {
  source = "github.com/mrichardson03/terraform-aws-panos-firewall?ref=v1.0.1"

  vpc_id   = module.vpc.vpc_id
  key_name = var.key_name

  ami = var.fw_ami

  mgmt_subnet_id = module.vpc.mgmt_subnet_ids[0]
  mgmt_sg_id     = module.vpc.mgmt_sg_id
  mgmt_ip        = "10.0.99.10"

  eth1_subnet_id = module.vpc.public_subnet_ids[0]
  eth1_sg_id     = module.vpc.public_sg_id
  eth1_ip        = "10.0.0.10"

  eth2_subnet_id = module.vpc.private_subnet_ids[0]
  eth2_sg_id     = module.vpc.internal_sg_id
  eth2_ip        = "10.0.1.10"

  iam_instance_profile = module.fw_bootstrap.instance_profile_name
  bootstrap_bucket     = module.fw_bootstrap.bucket_id

  tags = {
    Name        = "firewall"
    Environment = "CTF-Scoreboard"
  }
}

module "scoreboard" {
  source = "github.com/mrichardson03/terraform-aws-instance.git?ref=v0.0.2"

  key_name = var.key_name

  vpc_id     = module.vpc.vpc_id
  subnet_id  = module.vpc.private_subnet_ids[0]
  private_ip = "10.0.1.21"
  sg_id      = module.vpc.internal_sg_id

  instance_type = "t2.micro"
  ami           = "${data.aws_ami.ctf_scoreboard_ami.id}"

  tags = {
    Name        = "scoreboard"
    Environment = "CTF-Scoreboard"
  }
}
