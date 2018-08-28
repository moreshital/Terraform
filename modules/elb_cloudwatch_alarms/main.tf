#### ASG Notification
resource "aws_autoscaling_notification" "slack_notifications_arn" {
  group_names = ["${var.asg_name}"]

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]
  # topic_arn = "arn:aws:sns:ap-south-1:336296984562:hooq-cc-cloudwatch-alerts"
}

# A CloudWatch alarm that monitors memory utilization of containers for scaling up
resource "aws_cloudwatch_metric_alarm" "elb-5xx" {
  alarm_name          = "${var.lb_name}-ELB-5xx"
  alarm_description   = "This alarm monitors ${var.asg_name} ELB-5xx count"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "HTTPCode_ELB_5XX"
  namespace           = "AWS/ELB"
  period              = "300"
  statistic           = "Sum"
  threshold           = "50"
  datapoints_to_alarm = "1"
  treat_missing_data  = "notBreaching"
  alarm_actions       = ["${var.slack_notifications_arn}"]

  dimensions {
    Name = "${var.lb_name}"
  }
}

# A CloudWatch alarm that monitors memory utilization of containers for scaling up
resource "aws_cloudwatch_metric_alarm" "http-5xx" {
  alarm_name          = "${var.lb_name}-HTTP-5xx"
  alarm_description   = "This alarm monitors ${var.asg_name} HTTP-5xx count"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "HTTPCode_Backend_5XX"
  namespace           = "AWS/ELB"
  period              = "300"
  statistic           = "Sum"
  threshold           = "50"
  datapoints_to_alarm = "1"
  treat_missing_data  = "notBreaching"
  alarm_actions       = ["${var.slack_notifications_arn}"]

  dimensions {
    Name = "${var.lb_name}"
  }
}

# A CloudWatch alarm that monitors memory utilization of containers for scaling up
resource "aws_cloudwatch_metric_alarm" "elb-4xx" {
  alarm_name          = "${var.lb_name}-ELB-4xx"
  alarm_description   = "This alarm monitors ${var.asg_name} ELB-4xx count"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "HTTPCode_ELB_4XX"
  namespace           = "AWS/ELB"
  period              = "300"
  statistic           = "Sum"
  threshold           = "100"
  datapoints_to_alarm = "1"
  treat_missing_data  = "notBreaching"
  alarm_actions       = ["${var.slack_notifications_arn}"]


  dimensions {
    Name = "${var.lb_name}"
  }
}

# A CloudWatch alarm that monitors memory utilization of containers for scaling up
resource "aws_cloudwatch_metric_alarm" "http-4xx" {
  alarm_name          = "${var.lb_name}-HTTP-4xx"
  alarm_description   = "This alarm monitors ${var.asg_name} HTTP-4xx count"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "HTTPCode_Backend_4XX"
  namespace           = "AWS/ELB"
  period              = "300"
  statistic           = "Sum"
  threshold           = "100"
  datapoints_to_alarm = "1"
  treat_missing_data  = "notBreaching"
  alarm_actions       = ["${var.slack_notifications_arn}"]

  dimensions {
    LoadBalancer = "${var.lb_arn}"
  }
}

# A CloudWatch alarm that monitors memory utilization of containers for scaling up
resource "aws_cloudwatch_metric_alarm" "target-latnecy" {
  alarm_name          = "${var.lb_name}-Latency"
  alarm_description   = "This alarm monitors ${var.asg_name} latency"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "Latency"
  namespace           = "AWS/ELB"
  period              = "300"
  statistic           = "Average"
  threshold           = ".5"
  datapoints_to_alarm = "1"
  treat_missing_data  = "notBreaching"

  alarm_actions = ["${var.slack_notifications_arn}"]

  dimensions {
    LoadBalancer = "${var.lb_name}"
  }
}

# A CloudWatch alarm that monitors memory utilization of containers for scaling up
resource "aws_cloudwatch_metric_alarm" "unhealthy-hosts" {
  alarm_name          = "${var.lb_name}-Unhealthy-Hosts"
  alarm_description   = "This alarm monitors ${var.asg_name} Unhealthy-hosts count"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "UnHealthyHostCount"
  namespace           = "AWS/ELB"
  period              = "300"
  statistic           = "Average"
  threshold           = "1"
  datapoints_to_alarm = "1"
  treat_missing_data  = "missing"

  alarm_actions = ["${var.slack_notifications_arn}"]

  dimensions {
    LoadBalancer = "${var.lb_name}"
  }
}

resource "aws_sns_topic" "example" {
  name = "${}"

  # arn is an exported attribute
}
