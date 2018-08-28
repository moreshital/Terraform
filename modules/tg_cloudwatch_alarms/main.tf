# A CloudWatch alarm that Request Count per target
resource "aws_cloudwatch_metric_alarm" "request-per-target" {
  alarm_name          = "${var.tg_name}-Request-Counts-Per-Target"
  alarm_description   = "This alarm monitors ${var.asg_name} Request-Counts-Per-Target"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "RequestCountPerTarget"
  namespace           = "AWS/ApplicationELB"
  period              = "300"
  statistic           = "Average"
  threshold           = "500"
  datapoints_to_alarm = "1"
  treat_missing_data  = "notBreaching"
  alarm_actions       = ["${var.slack_notifications_arn}"]

  dimensions {
    TargetGroup = "${var.tg_arn}"
  }
}

# A CloudWatch alarm that monitors UnHealthyHost Per TG
resource "aws_cloudwatch_metric_alarm" "unhealthy-hosts" {
  alarm_name          = "${var.lb_name}-Unhealthy-Hosts"
  alarm_description   = "This alarm monitors ${var.asg_name} Unhealthy-hosts count"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "UnHealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = "300"
  statistic           = "Average"
  threshold           = "1"
  datapoints_to_alarm = "1"
  treat_missing_data  = "missing"

  alarm_actions = ["${var.slack_notifications_arn}"]

  dimensions {
    LoadBalancer = "${var.lb_arn}"
    TargetGroup  = "${var.tg_arn}"
  }
}
