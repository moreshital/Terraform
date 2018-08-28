variable "cluster_name" {
  description = "Name of ECS cluster"
}

variable "slack_notifications" {
  description = "slack Notification"
}

variable "scaling_policy_type" {
  description = "ECS Scaling Policy Type"
  default = "SimpleScaling"

}

variable "asg_name" {
}

variable "asg_arn" {
}

