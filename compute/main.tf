#----compute/main.tf#----
data "aws_ami" "server_ami" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm*-x86_64-gp2"]
  }
}

resource "aws_key_pair" "lab_auth" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

data "template_file" "user-init" {

  template = "${file("${path.module}/userdata.tpl")}"
}

resource "aws_instance" "lab_app" {

  count         = "${var.instance_count}"
  instance_type = "${var.instance_type}"
  ami           = "${data.aws_ami.server_ami.id}"

  tags {
    Name = "WebServer-${count.index +1}"

  }

  key_name               = "${aws_key_pair.lab_auth.id}"
  vpc_security_group_ids = ["${var.security_group}"]
  subnet_id              = "${element(var.subnets, count.index)}"
  user_data              = "${data.template_file.user-init.rendered}"


}


#-------Launch configuration ----------

resource "aws_launch_configuration" "lab_lc" {
  name = "webservers"
 
  image_id               = "${data.aws_ami.server_ami.id}"
  key_name               = "${aws_key_pair.lab_auth.id}"
  security_groups = ["${var.security_group}"]
  instance_type          = "${var.instance_type}"

  lifecycle {
    create_before_destroy = true
  }
  

  user_data              = "${base64encode(data.template_file.user-init.rendered)}"

}

