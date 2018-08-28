# The auto scaling group that specifies how we want to scale the number of EC2 Instances in the cluster

resource "aws_autoscaling_group" "main" {
  name = "${var.name}-asg"

  availability_zones   = ["${var.availability_zones}"]
  vpc_zone_identifier  = ["${var.subnet_ids}"]
  launch_configuration = "${var.launch_configuration}"
  min_size             = "${var.min_size}"
  max_size             = "${var.max_size}"
  desired_capacity     = "${var.desired_capacity}"
  health_check_type    = "ELB"
  load_balancers       = ["${var.elb_name}"]
  enabled_metrics      = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
  termination_policies = ["OldestLaunchConfiguration", "Default"]

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "${var.name}-asg"
    propagate_at_launch = true
  }

  tag {
    key                 = "Entity"
    value               = "${var.entity}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = "${var.environment}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Application"
    value               = "${var.application}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Application-Type"
    value               = "${var.application-type}"
    propagate_at_launch = true
  }
}
