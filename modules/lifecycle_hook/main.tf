resource "aws_autoscaling_lifecycle_hook" "main" {
  name                   = "${var.asg_name}"
  autoscaling_group_name = "${var.asg_name}"
  default_result         = "CONTINUE"
  heartbeat_timeout      = "${var.heartbeat_timeout}"
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_LAUNCHING"
}
