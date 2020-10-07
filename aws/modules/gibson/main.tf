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
 