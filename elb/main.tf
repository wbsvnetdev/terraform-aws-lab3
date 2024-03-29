#Creeate a new load balancer



resource "aws_elb" "lab_elb" {
 
  name               = "lab-elb"
  subnets            = ["${var.subnets}"]
  security_groups     = ["${var.security_groups}"]
  internal            = false

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/index.html"
    interval            = 30
  }

  
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "lab_elb"
  }
}
