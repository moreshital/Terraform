# A CloudWatch alarm that monitors memory utilization of containers for scaling up
resource "aws_cloudwatch_metric_alarm" "cluster_memory_high" {
  alarm_name          = "${var.cluster_name}-memory-reservation-above-65"
  alarm_description   = "This alarm monitors ${var.cluster_name} memory reservation for scaling up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "MemoryReservation"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "65"
  datapoints_to_alarm = "1"
  alarm_actions       = ["${var.slack_notifications}"]

  dimensions {
    ClusterName = "${var.cluster_name}"
  }
}

/*
# A CloudWatch alarm that monitors memory utilization of containers for scaling down
resource "aws_cloudwatch_metric_alarm" "cluster_memory_low" {
  alarm_name          = "${var.cluster_name}-memory-reservation-below-40"
  alarm_description   = "This alarm monitors ${var.cluster_name} memory reservation for scaling down"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "MemoryReservation"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "40"
  datapoints_to_alarm = "1"
  alarm_actions       = ["${var.slack_notifications}"]

  dimensions {
    ClusterName = "${var.cluster_name}"
  }
}
*/

##### CPU policy

# A CloudWatch alarm that moniors CPU utilization of containers for scaling up
resource "aws_cloudwatch_metric_alarm" "aws_service_cpu_high" {
  alarm_name          = "${var.cluster_name}-cpu-utilization-above-60"
  alarm_description   = "This alarm monitors ${var.cluster_name} CPU reservation for scaling up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUReservation"
  namespace           = "AWS/ECS"
  period              = "120"
  statistic           = "Average"
  threshold           = "60"
  datapoints_to_alarm = "1"
  alarm_actions       = ["${aws_autoscaling_policy.scale_up.arn}", "${var.slack_notifications}"]

  dimensions {
    ClusterName = "${var.cluster_name}"
  }
}

# A CloudWatch alarm that monitors CPU utilization of containers for scaling down
resource "aws_cloudwatch_metric_alarm" "service_cpu_low" {
  alarm_name          = "${var.cluster_name}-cpu-utilization-below-30"
  alarm_description   = "This alarm monitors ${var.cluster_name} CPU reservation for scaling down"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUReservation"
  namespace           = "AWS/ECS"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"
  datapoints_to_alarm = "1"
  alarm_actions       = ["${aws_autoscaling_policy.scale_down.arn}"]

  dimensions {
    ClusterName = "${var.cluster_name}"
  }
}

### END CPU

resource "aws_autoscaling_policy" "scale_up" {
  name                   = "${var.asg_name}-instances-scale-up"
  scaling_adjustment     = 1
  cooldown               = 300
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = "${var.asg_name}"
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "${var.asg_name}-instances-scale-down"
  scaling_adjustment     = -1
  cooldown               = 300
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = "${var.asg_name}"
}
