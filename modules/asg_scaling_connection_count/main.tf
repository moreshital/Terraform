
resource "aws_autoscaling_policy" "scale_up" {
  name                   = "${var.asg_name}-instances-scale-up"
  scaling_adjustment     = 1
  cooldown               = 300
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = "${var.asg_name}"
}

# A CloudWatch alarm that monitors memory utilization of containers for scaling up
resource "aws_cloudwatch_metric_alarm" "request-per-target" {
  alarm_name          = "${var.tg_name}-Request-Counts-Per-Target-Up"
  alarm_description   = "This alarm monitors ${var.asg_name} Request-Counts-Per-Target"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "RequestCountPerTarget"
  namespace           = "AWS/ApplicationELB"
  period              = "300"
  statistic           = "Average"
  threshold           = "3000"
  datapoints_to_alarm = "1"
  treat_missing_data  = "notBreaching"
  alarm_actions       = ["${var.slack_notifications_arn}", "aws_autoscaling_policy.scale_up.arn"]

  dimensions {
    TargetGroup = "${var.tg_arn}"
  }
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "${var.asg_name}-instances-scale-down"
  scaling_adjustment     = -1
  cooldown               = 300
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = "${var.asg_name}"
}

# A CloudWatch alarm that monitors memory utilization of containers for scaling up
resource "aws_cloudwatch_metric_alarm" "request-per-target" {
  alarm_name          = "${var.tg_name}-Request-Counts-Per-Target-Down"
  alarm_description   = "This alarm monitors ${var.asg_name} Request-Counts-Per-Target"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "RequestCountPerTarget"
  namespace           = "AWS/ApplicationELB"
  period              = "300"
  statistic           = "Average"
  threshold           = "2000"
  datapoints_to_alarm = "1"
  treat_missing_data  = "notBreaching"
  alarm_actions       = ["${var.slack_notifications_arn}", "aws_autoscaling_policy.scale_down.arn"]

  dimensions {
    TargetGroup = "${var.tg_arn}"
  }
