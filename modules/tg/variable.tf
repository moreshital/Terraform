variable "name" {
  description = "AWS ALB Name"
}

variable "internal_value" {
  default = ""
}

variable "key_name" {
  description = "SSH Key used for EC2"
  default     = ""
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

variable "cert_acm_arn" {
  default = ""
}

variable "alb_arn" {
  default = ""
}

variable "vpc_id" {
  default = ""
}


