resource "aws_instance" "franklin-iac" {
  ami           = "${var.ami}"
  instance_type = "t2.micro"
  key_name      = "${var.key_name}"

  # comma separated list of groups
  vpc_security_group_ids      = ["${aws_security_group.iac_sec_grp.id}"]
  subnet_id                   = "${aws_subnet.franklin-iac.id}"
  associate_public_ip_address = "true"

  root_block_device {
    volume_size           = "10"
    volume_type           = "standard"
    delete_on_termination = "true"
  }
  tags = {
    Name = "ubuntu-ctf-scoreboard"
  }

  connection {
    user    = "ubuntu"
  //  timeout = "1m"
  //  #agent       = false
  //  private_key = "${file("~/.ssh/id_rsa")}"
  }
}
