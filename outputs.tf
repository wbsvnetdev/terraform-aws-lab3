#----root/outputs.tf-----

#---Networking Outputs -----

output "Public Subnets" {
  value = "${module.networking.public_subnets}"
}

output "Subnet IPs" {
  value = "${module.networking.subnet_ips}"
}

output "Public Security Group" {
  value = "${module.networking.public_sg}"
}

output "VPC ID" {
  value = "${module.networking.vpc_id}"
}

#---Compute Outputs ------

output "Launch configuration name" {
  value = "${module.compute.lc_name}"
}

output "Public Instance IDs" {
  value = "${module.compute.server_id}"
}

output "Public Instance IPs" {
  value = "${module.compute.server_ip}"
}


#-----ELastic Load Balancer Outputs -------

 output "Elastic Load Balancer Name" {
  value = "${module.elb.load_balancers}"
}

 output "Elastic Load Balancer ID" {
  value = "${module.elb.load_balancer_id}"
}

