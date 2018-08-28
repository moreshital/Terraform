# A CloudWatch alarm that moniors CPU utilization of containers for scaling up
resource "aws_cloudwatch_metric_alarm" "aws_service_cpu_high" {
  alarm_name          = "${var.service_name}-cpu-utilization-above-50"
  alarm_description   = "This alarm monitors ${var.service_name} CPU utilization for scaling up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "${var.cpu_high_thershold}"
  datapoints_to_alarm = "1"
  alarm_actions       = ["${aws_appautoscaling_policy.scale_up.arn}", "${var.slack_notifications}"]

  dimensions {
    ClusterName = "${var.cluster_name}"
    ServiceName = "${var.service_name}"
  }
}

# A CloudWatch alarm that monitors CPU utilization of containers for scaling down
resource "aws_cloudwatch_metric_alarm" "service_cpu_low" {
  alarm_name          = "${var.service_name}-cpu-utilization-below-40"
  alarm_description   = "This alarm monitors ${var.service_name} CPU utilization for scaling down"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "${var.cpu_low_thershold}"
  datapoints_to_alarm = "1"
  alarm_actions       = ["${aws_appautoscaling_policy.scale_down.arn}"]

  dimensions {
    ClusterName = "${var.cluster_name}"
    ServiceName = "${var.service_name}"
  }
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

   # Step 1 (Normal)
  step_adjustment {
    scaling_adjustment          = "${var.step_up_1_scaling_adjustment}"
    metric_interval_lower_bound = "${var.step_up_1_lower_bound}"
    metric_interval_upper_bound = "${var.step_up_1_upper_bound}"
  }

  # Step 2 (Spike)
  step_adjustment {
    scaling_adjustment          = "${var.step_up_2_scaling_adjustment}"
    metric_interval_lower_bound = "${var.step_up_2_lower_bound}"
    metric_interval_upper_bound = "${var.step_up_2_upper_bound}"
  }

  # Step 3 (Spike)
  step_adjustment {
    scaling_adjustment          = "${var.step_up_3_scaling_adjustment}"
    metric_interval_lower_bound = "${var.step_up_3_lower_bound}"
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

   # Step 1 (Normal)
  step_adjustment {
    scaling_adjustment          = "${var.step_down_1_scaling_adjustment}"
    metric_interval_lower_bound = "${var.step_down_1_lower_bound}"
    metric_interval_upper_bound = "${var.step_down_1_upper_bound}"
  }


  # Step 2 (Spike)
  step_adjustment {
    scaling_adjustment          = "${var.step_down_2_scaling_adjustment}"
    metric_interval_lower_bound = "${var.step_down_2_lower_bound}"
    metric_interval_upper_bound = "${var.step_down_2_upper_bound}"
  }


  # Step 2 (Spike)
  step_adjustment {
    scaling_adjustment          = "${var.step_down_3_scaling_adjustment}"
    metric_interval_lower_bound = "${var.step_down_3_lower_bound}"
    metric_interval_upper_bound = "${var.step_down_3_upper_bound}"
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
}
