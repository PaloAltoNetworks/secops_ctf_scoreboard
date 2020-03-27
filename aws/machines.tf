resource "aws_instance" "franklin-iac" {
  connection {
    user    = "centos"
    timeout = "1m"
    #agent       = false
    private_key = "${file("/home/thedevilsvoice/.ssh/do_terra_rsa")}"
  }
  ami           = "ami-d2c924b2"
  instance_type = "t2.micro"
  key_name      = "${var.key_name}"
  # comma separated list of groups
  vpc_security_group_ids      = ["${aws_security_group.iac_sec_grp.id}"]
  subnet_id                   = "${aws_subnet.franklin-iac.id}"
  associate_public_ip_address = true
  tags {
    Name = "franklin-iac"
  }
}