aws_region   = "us-east-1"
project_name = "lab"
vpc_cidr     = "10.0.0.0/16"
public_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]
accessip    = "0.0.0.0/0"

key_name = "lab_key"
public_key_path = "/root/.ssh/id_rsa.pub"
server_instance_type = "t2.micro"
instance_count = 2

asg_launch_template = "lt-0dd3cc474fc5c3e8a"
