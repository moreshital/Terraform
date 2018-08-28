#CloudWatch alarm that monitors memory utilization of ECS Instance
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
  threshold           = "55"
  datapoints_to_alarm = "1"
  alarm_actions       = ["${aws_autoscaling_policy.scale_up.arn}", "${var.slack_notifications}"]

  dimensions {
    ClusterName = "${var.cluster_name}"
  }
}

## Scale-Up Policy
resource "aws_autoscaling_policy" "scale_up" {
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = "${var.asg_name}"
  name                   = "${var.asg_name}-scale-up"
  policy_type            = "StepScaling"
  

  # Step 1 (Normal)
  step_adjustment {
    scaling_adjustment          = 2
    metric_interval_lower_bound = 0
    metric_interval_upper_bound = 10
  }

  # Step 2 (Spike)
  step_adjustment {
    scaling_adjustment          = 3
    metric_interval_lower_bound = 10
    metric_interval_upper_bound = 20
  }

  # Step 2 (Spike)
  step_adjustment {
    scaling_adjustment          = 5
    metric_interval_lower_bound = 20
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
  period              = "60"
  statistic           = "Average"
  threshold           = "30"
  datapoints_to_alarm = "1"
  alarm_actions       = ["${aws_autoscaling_policy.scale_down.arn}"]

  dimensions {
    ClusterName = "${var.cluster_name}"
  }
}

### END CPU


resource "aws_autoscaling_policy" "scale_down" {
  name                   = "${var.asg_name}-instances-scale-down"
  scaling_adjustment     = -1
  cooldown               = 120
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = "${var.asg_name}"
}
