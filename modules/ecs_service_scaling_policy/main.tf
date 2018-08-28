# A CloudWatch alarm that moniors CPU utilization of containers for scaling up
resource "aws_cloudwatch_metric_alarm" "aws_service_cpu_high" {
  alarm_name          = "${var.service_name}-cpu-utilization-above-60"
  alarm_description   = "This alarm monitors ${var.service_name} CPU utilization for scaling up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "60"
  datapoints_to_alarm = "1"
  alarm_actions       = ["${aws_appautoscaling_policy.scale_up.arn}", "${var.slack_notifications}"]

  dimensions {
    ClusterName = "${var.cluster_name}"
    ServiceName = "${var.service_name}"
  }
}

# A CloudWatch alarm that monitors CPU utilization of containers for scaling down
resource "aws_cloudwatch_metric_alarm" "service_cpu_low" {
  alarm_name          = "${var.service_name}-cpu-utilization-below-30"
  alarm_description   = "This alarm monitors ${var.service_name} CPU utilization for scaling down"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "30"
  datapoints_to_alarm = "1"
  alarm_actions       = ["${aws_appautoscaling_policy.scale_down.arn}"]

  dimensions {
    ClusterName = "${var.cluster_name}"
    ServiceName = "${var.service_name}"
  }
  depends_on = ["aws_appautoscaling_policy.scale_down"]
}

resource "aws_appautoscaling_policy" "scale_up" {
  name               = "${var.service_name}-scale-up"
  resource_id        = "service/${var.cluster_name}/${var.service_name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  step_scaling_policy_configuration {
    cooldown                = 60
    metric_aggregation_type = "Maximum"
    adjustment_type         = "ChangeInCapacity"

    step_adjustment {
      metric_interval_lower_bound = 0
      #metric_interval_upper_bound = 1.0
      scaling_adjustment          = 1
    }
  }
}

resource "aws_appautoscaling_policy" "scale_down" {
  name               = "${var.service_name}-scale-down"
  resource_id        = "service/${var.cluster_name}/${var.service_name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  step_scaling_policy_configuration {
    cooldown                = 60
    metric_aggregation_type = "Maximum"
    adjustment_type         = "ChangeInCapacity"

    step_adjustment {
      metric_interval_lower_bound = -1.0
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }
}

# A CloudWatch alarm that monitors memory utilization of containers
resource "aws_cloudwatch_metric_alarm" "service_memory_high" {
  alarm_name          = "${var.service_name}-memory-utilization-above-65"
  alarm_description   = "This alarm monitors ${var.service_name} memory utilization for scaling up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "65"
  datapoints_to_alarm = "1"
  alarm_actions       = ["${var.slack_notifications}"]

  dimensions {
    ClusterName = "${var.cluster_name}"
    ServiceName = "${var.service_name}"
  }
  depends_on = ["aws_appautoscaling_policy.scale_up"]
}
/*
# A CloudWatch alarm that monitors memory utilization of containers
resource "aws_cloudwatch_metric_alarm" "service_memory_low" {
  alarm_name          = "${var.service_name}-memory-utilization-below-40"
  alarm_description   = "This alarm monitors ${var.service_name} memory utilization for scaling down"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "40"
  datapoints_to_alarm = "1"
  alarm_actions       = ["${var.slack_notifications}"]

  dimensions {
    ClusterName = "${var.cluster_name}"
    ServiceName = "${var.service_name}"
  }
}
*/
