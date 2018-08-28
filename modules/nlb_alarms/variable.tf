variable "lb_name" {
  description = "Name of ALB"
}

variable "lb_arn" {
  default = ""
}

variable "asg_name" {
  default = ""
}

variable "asg_arn" {
  default = ""
}

variable "tg_name" {
  default = ""
}

variable "tg_arn" {
  default = ""
}

variable "slack_notifications_arn" {
  default = ""
}
