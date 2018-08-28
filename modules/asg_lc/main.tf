# The auto scaling group that specifies how we want to scale the number of EC2 Instances
data "template_file" "main" {
  template = "${file("files/user_data/${var.userdata}")}"
  #template = "${file("${var.userdata}")}"
}

resource "aws_launch_configuration" "main" {
  name_prefix        = "${var.name}-lc-"
  instance_type        = "${var.instance_type}"
  key_name             = "${var.key_name}"
  iam_instance_profile = "${var.role_arn}"
  security_groups      = ["${var.security_groups}"]
  image_id             = "${var.ami_id}"

  user_data = "${data.template_file.main.rendered}"

  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_autoscaling_group" "main" {
  name                 = "${var.name}-asg"
  availability_zones   = ["${var.availability_zones}"]
  vpc_zone_identifier  = ["${var.subnet_ids}"]
  launch_configuration = "${aws_launch_configuration.main.id}"
  min_size             = "${var.min_size}"
  max_size             = "${var.max_size}"
  desired_capacity     = "${var.desired_capacity}"
  health_check_type    = "EC2"
  enabled_metrics      = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
  termination_policies = ["OldestLaunchConfiguration", "Default"]
  target_group_arns    = ["${var.target_group_arn}"]
  depends_on          = ["aws_launch_configuration.main"]
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
    key                 = "LogRotate"
    value               = "${var.logrotate}"
    propagate_at_launch = true
  }
}
