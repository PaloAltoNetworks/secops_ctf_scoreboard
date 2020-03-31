provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "github.com/mrichardson03/terraform-aws-vpc"

  name = "CTF-VPC"

  cidr_block = var.vpc_cidr
  azs        = [var.availability_zone]

  create_mgmt_subnets = false
  public_subnet_cidrs = [var.public_subnet_cidr]

  tags = {
    Environment = "CTF-Scoreboard"
  }
}
