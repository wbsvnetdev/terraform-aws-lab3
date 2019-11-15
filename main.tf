#----root/main.tf-----
provider "aws" {
  region = "${var.aws_region}"
}


# Deploy Networking Resources
module "networking" {
  source       = "./networking"
  vpc_cidr     = "${var.vpc_cidr}"
  public_cidrs = "${var.public_cidrs}"
  accessip     = "${var.accessip}"
}

# Deploy Compute Resources
module "compute" {
  source          = "./compute"
  instance_count  = "${var.instance_count}"
  key_name        = "${var.key_name}"
  public_key_path = "${var.public_key_path}"
  instance_type   = "${var.server_instance_type}"
  subnets         = "${module.networking.public_subnets}"
  security_group  = "${module.networking.public_sg}"
  subnet_ips      = "${module.networking.subnet_ips}"
  
}


#Deploy Elastic Load Balancer Resource
module "elb" {
  source              = "./elb"
  subnets             = "${module.networking.public_subnets}"
  security_groups     = "${module.networking.public_sg}"
  vpc_id              = "${module.networking.vpc_id}"
}

#Deploy Autoscaling group
module "asg" {
 source                                = "./asg"
 lc_name                               = "${module.compute.lc_name}"
 load_balancer_id                      = "${module.elb.load_balancer_id}"
 subnets                               = "${module.networking.public_subnets}"
}


