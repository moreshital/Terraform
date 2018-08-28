resource "aws_autoscaling_policy" "scale_up" {
  name                   = "${var.asg_name}-instances-scale-up"
  scaling_adjustment     = 1
  cooldown               = 300
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = "${var.asg_name}"
}

# A CloudWatch alarm that monitors CPU utilization of cluster instances for scaling up
resource "aws_cloudwatch_metric_alarm" "instances_cpu_high" {
  evaluation_periods  = "1"
  threshold           = "65"
  period              = "300"
  statistic           = "Average"
  metric_name         = "CPUUtilization"
  namespace           = "${var.namespace}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  alarm_actions       = ["${aws_autoscaling_policy.scale_up.arn}"]
  alarm_name        = "${var.asg_name}-instances-CPU-Utilization-Above-65"
  alarm_description = "This alarm monitors ${var.asg_name} instances CPU utilization for scaling up"

  dimensions {
    AutoScalingGroupName = "${var.asg_name}"
  }
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "${var.asg_name}-instances-scale-down"
  scaling_adjustment     = -1
  cooldown               = 300
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = "${var.asg_name}"
}

# A CloudWatch alarm that monitors CPU utilization of cluster instances for scaling down
resource "aws_cloudwatch_metric_alarm" "instances_cpu_low" {
  evaluation_periods  = "1"
  threshold           = "45"
  period              = "300"
  statistic           = "Average"
  metric_name         = "CPUUtilization"
  namespace           = "${var.namespace}"
  comparison_operator = "LessThanOrEqualToThreshold"
  alarm_actions       = ["${aws_autoscaling_policy.scale_down.arn}"]
  alarm_name        = "${var.asg_name}-instances-CPU-Utilization-Below-45"
  alarm_description = "This alarm monitors ${var.asg_name} instances CPU utilization for scaling down"

  dimensions {
    AutoScalingGroupName = "${var.asg_name}"
  }
}
