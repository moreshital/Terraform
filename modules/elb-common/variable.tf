variable "environment" {
  description = "Environment (e.g. nightly/sandbox/production/etc2)"
}

variable "subnet_ids" {
  type        = "list"
  description = "NLB subnets"
}

variable "name" {
  default = ""
}

variable "entity" {
  default = ""
}

variable "internal_lb_value" {
  default = ""
}

variable "application" {
  default = "default"
}

variable "instance_port" {

}

variable "instance_protocol" {

}

variable "lb_port" {

}

variable "lb_protocol" {

}
variable "log_bucket" {}

variable "elb_healthcheck_path" {}
variable "security_groups" { type = "list"}
variable "cert_acm_arn" {}