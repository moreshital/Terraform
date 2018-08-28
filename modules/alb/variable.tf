variable "name" {
  description = "AWS ALB Name"
}

variable "internal_lb_value" {}

variable "entity" {
  description = "Entity Name"
}

variable "environment" {
  description = "Environment Name"
}

variable "subnet_ids" {
  description = "A list of subnet IDs"
  type        = "list"
}

variable "security_groups" {
  description = "A list of SG IDs"
  type = "list"
}

variable "log_bucket" {
  
}