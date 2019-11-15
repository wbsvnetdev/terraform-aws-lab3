#-----Creeate an autoscaling group-----


resource "aws_autoscaling_group" "lab_asg" {
  availability_zones        = ["us-east-1a"]
  desired_capacity          = 2
  max_size                  = 3
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
  launch_configuration      = "${var.lc_name}"
  vpc_zone_identifier       = ["${var.subnets}"]

 tag {
    key                 = "Name"
    value               = "AutoScalingWebServer"
    propagate_at_launch = true
  }

}

resource "aws_autoscaling_attachment" "asg_attachment_lab" {
  autoscaling_group_name = "${aws_autoscaling_group.lab_asg.id}"
  elb                    = "${var.load_balancer_id}"
}
