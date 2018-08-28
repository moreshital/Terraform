variable "name" {
  description = "Classic ELB name"
}

variable "environment" {
  default = ""
}

variable "entity" {
  default = ""
}


variable "subnet_ids" {
  description = "A list of subnet IDs"
  type        = "list"
}

variable "elb_type" {
  description = "ELB Accessiblity type"
}

variable "cert_acm_arn" {
  default = ""
}

variable "security_groups" {
  description = "A list of subnet IDs"
  type = "list"
}

variable "instance_port2" {
	
}
variable "lb_port1"{
	
}
variable "lb_protocol1" {
	
}
variable "instance_protocol1" {
	
}
variable "target_healthcheck" {
	
}
variable "connection_drain_timeout" {
	
}
variable "internal_status" {
	
}
variable "instance_port1" {
  
}
variable "instance_protocol2" {
  
}
variable "lb_port2" {
  
}
variable "lb_protocol2" {
  
}
variable "application" {
  
}
