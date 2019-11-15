#-----networking/outputs.tf----

output "public_subnets" {
  value = ["${aws_subnet.lab_public_subnet.*.id}"]
}

output "public_sg" {
  value = "${aws_security_group.lab_public_sg.id}"
}

output "subnet_ips" {
  value = "${aws_subnet.lab_public_subnet.*.cidr_block}"
}

output "vpc_id" {
  value = "${aws_vpc.lab_vpc.id}"
}
