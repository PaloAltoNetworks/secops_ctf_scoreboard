variable "gibson_ami" {
  description = "Which AMI to use for this instance"
  type        = string
}

variable "gibson_instance_type" {
  description = ""
  type        = string
}

variable "gibson_subnet_id" {
  description = ""
  type        = string
}

variable "gibson_vpc_security_group_ids" {
  description = ""
  type        = list
}


variable "gibson_associate_public_ip_address" {
  description = ""
  type        = string
}
