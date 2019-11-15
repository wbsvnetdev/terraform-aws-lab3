#-------------- elb/outputs.tf --------------

output "load_balancers" {
   value = "${aws_elb.lab_elb.dns_name}"
}

output "load_balancer_id" {
   value = "${aws_elb.lab_elb.id}"
}
