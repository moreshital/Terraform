variable "name" {
  default = ""
}

variable "region" {
  description = "AWS Region, e.g us-west-2"
}



variable "availability_zones" {
  type = "list"
}

variable "application" {
  default = ""
}

variable "entity" {}


variable "environment" {
  description = "Environment tag, e.g prod"
}

variable "key_name" {}

variable "vpc_id" {}
variable "instance_type" {}
variable "service_name" {}
variable "app_private_subnet_ids" {
  type = "list"
}
variable "desired_capacity" {}
variable "max_size" {}
variable "min_size" {}
variable "common_security_group" { type = "list" }
variable  "userdata" {}

variable "lb_private_subnet_ids" { type = "list" }
variable "log_bucket" { }
variable "tg_port" {}
variable "alb_healthcheck_path" {}
variable "zone_id" {}
variable "dns_record_name" {}
variable "cert_acm_arn" {}
variable "security_groups_name" {}
variable "lb_private_security_group" {type = "list"}
variable "ami_name_pattern" {}
variable "ami_name_regex" {}
variable "instance_protocol" {}
variable "lb_port" {}
variable "lb_protocol" {}
variable "internal_status" {}
variable "lb_public_subnet_ids" { type = "list"}
variable "lb_public_security_group" { type = "list"}
variable "elb_healthcheck_path" {}
variable "instance_port" {}
