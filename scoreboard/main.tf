provider "aws" {
  region = var.aws_region
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = var.public_key
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

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3.0"

  name        = "example"
  description = "Security group for CTF Scoreboard"
  vpc_id      = data.aws_vpc.default.id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "ssh-tcp", "all-icmp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 8000
      to_port     = 8000
      protocol    = "tcp"
      description = "CTFd web server"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  egress_rules = ["all-all"]
}

resource "aws_network_interface" "this" {
  count     = 1
  subnet_id = tolist(data.aws_subnet_ids.all.ids)[count.index]
}

module "ec2" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name                        = "SecOps_CTF_Scoreboard"
  ami                         = var.ami
  instance_type               = "t2.micro"
  subnet_id                   = tolist(data.aws_subnet_ids.all.ids)[0]
  vpc_security_group_ids      = [module.security_group.this_security_group_id]
  associate_public_ip_address = true

  tags = {
    Name        = "scoreboard"
    Terraform   = "true"
    Environment = "CTF-Scoreboard"
  }
}

module "gibson" {
  source = "./modules/gibson"

  gibson_ami                         = var.ami
  gibson_instance_type               = "t2.micro"
  gibson_subnet_id                   = tolist(data.aws_subnet_ids.all.ids)[0]
  gibson_vpc_security_group_ids      = [module.security_group.this_security_group_id]
  gibson_associate_public_ip_address = true
}

module "dns" {
  source = "./modules/dns"

  dns_vpc      = data.aws_vpc.default.id
  dns_hostname = ["scoreboard", "gibson"]
  dns_arecord = [

  ]
}

/**
 *  Copyright 2019 Palo Alto Networks.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
 