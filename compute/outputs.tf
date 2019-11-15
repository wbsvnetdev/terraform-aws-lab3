#-----compute/outputs.tf-----

output "server_id" {
  value = "${aws_instance.lab_app.*.id}"
}

output "server_ip" {
  value = "${aws_instance.lab_app.*.public_ip}"
}

output "lc_name" {
  value = "${aws_launch_configuration.lab_lc.name}"
}
