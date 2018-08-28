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
