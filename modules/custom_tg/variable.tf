variable "name" {
  description = "AWS ALB Name"
}



variable "http_code" {
  description = "HTTP Code for health check"
  default     = ""
}

variable "entity" {
  description = "Entity Name"
  default     = ""
}

variable "environment" {
  description = "Environment Name"
  default     = ""
}

variable "alb_port" {
  description = "ALB Port to Monitor"
  default     = ""
}

variable "alb_check_path" {
  default = ""
}

variable "alb_arn" {
  default = ""
}

variable "vpc_id" {
  default = ""
}


