# A CloudWatch alarm for NewFlowCount
resource "aws_cloudwatch_metric_alarm" "new-flow" {
  alarm_name          = "${var.lb_name}-NewFlow"
  alarm_description   = "This alarm monitors ${var.lb_arn} NewFlow Count"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "NewFlowCount"
  namespace           = "AWS/NetworkELB"
  period              = "300"
  statistic           = "Average"
  threshold           = "1"
  datapoints_to_alarm = "1"
  treat_missing_data  = "missing"

  alarm_actions = ["${var.slack_notifications_arn}"]

  dimensions {
    LoadBalancer = "${var.lb_arn}"
  }
}

# A CloudWatch alarm TCP_ELB_Reset_Count
resource "aws_cloudwatch_metric_alarm" "elb-reset" {
  alarm_name          = "${var.lb_name}-ELB-Reset"
  alarm_description   = "This alarm monitors ${var.lb_arn} TCP_ELB_Reset Count"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "TCP_ELB_Reset_Count"
  namespace           = "AWS/NetworkELB"
  period              = "300"
  statistic           = "Average"
  threshold           = "1"
  datapoints_to_alarm = "1"
  treat_missing_data  = "missing"

  alarm_actions = ["${var.slack_notifications_arn}"]

  dimensions {
    LoadBalancer = "${var.lb_arn}"
  }
}

# A CloudWatch alarm TCP_Client_Reset_Count
resource "aws_cloudwatch_metric_alarm" "client-reset" {
  alarm_name          = "${var.lb_name}-Client-Reset"
  alarm_description   = "This alarm monitors ${var.lb_arn} Client_Reset Count"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "TCP_Client_Reset_Count"
  namespace           = "AWS/NetworkELB"
  period              = "300"
  statistic           = "Average"
  threshold           = "1"
  datapoints_to_alarm = "1"
  treat_missing_data  = "missing"

  alarm_actions = ["${var.slack_notifications_arn}"]

  dimensions {
    LoadBalancer = "${var.lb_arn}"
  }
}

# A CloudWatch alarm TCP_Target_Reset_Count
resource "aws_cloudwatch_metric_alarm" "target-reset" {
  alarm_name          = "${var.lb_name}-Target-Reset"
  alarm_description   = "This alarm monitors ${var.lb_arn} Target_Reset Count"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "TCP_Target_Reset_Count"
  namespace           = "AWS/NetworkELB"
  period              = "300"
  statistic           = "Average"
  threshold           = "1"
  datapoints_to_alarm = "1"
  treat_missing_data  = "missing"

  alarm_actions = ["${var.slack_notifications_arn}"]

  dimensions {
    LoadBalancer = "${var.lb_arn}"
  }
}

# A CloudWatch alarm ConsumedLCUs
resource "aws_cloudwatch_metric_alarm" "consumedlcu" {
  alarm_name          = "${var.lb_name}-ConsumedLCU"
  alarm_description   = "This alarm monitors ${var.lb_arn} ConsumedLCUs count"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "ConsumedLCUs"
  namespace           = "AWS/NetworkELB"
  period              = "300"
  statistic           = "Average"
  threshold           = "1"
  datapoints_to_alarm = "1"
  treat_missing_data  = "missing"

  alarm_actions = ["${var.slack_notifications_arn}"]

  dimensions {
    LoadBalancer = "${var.lb_arn}"
  }
}

# A CloudWatch alarm ActiveFlowCount
resource "aws_cloudwatch_metric_alarm" "active-flow" {
  alarm_name          = "${var.lb_name}-ActiveFlow"
  alarm_description   = "This alarm monitors ${var.lb_arn} ActiveFlow count"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "ActiveFlowCount"
  namespace           = "AWS/NetworkELB"
  period              = "300"
  statistic           = "Average"
  threshold           = "1"
  datapoints_to_alarm = "1"
  treat_missing_data  = "missing"

  alarm_actions = ["${var.slack_notifications_arn}"]

  dimensions {
    LoadBalancer = "${var.lb_arn}"
  }
}

# A CloudWatch alarm UnHealthyHostCount
resource "aws_cloudwatch_metric_alarm" "unHealthy-host" {
  alarm_name          = "${var.lb_name}-UnHealthyHost"
  alarm_description   = "This alarm monitors ${var.lb_arn} UnHealthyHost count"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "UnHealthyHostCount"
  namespace           = "AWS/NetworkELB"
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
