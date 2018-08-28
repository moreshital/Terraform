variable "service_name" {
  description = "Name of service"
}

variable "cluster_name" {
  description = "Name of ECS cluster"
}

variable "asg_name" {
}

variable "asg_arn" {
}

variable "slack_notifications" {
  description = "slack Notification"
}
