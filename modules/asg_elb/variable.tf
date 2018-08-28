variable "name" {
  default = ""
}

variable "region" {
  description = "AWS Region, e.g us-west-2"
}

variable "launch_configuration" {
  default = ""
}

variable "elb_name" {
  default = ""
}

variable "desired_capacity" {
  default = "2"
}


variable "max_size" {
  default = ""
}

variable "min_size" {
  default = ""
}

variable "availability_zones" {
  type = "list"
}

variable "application" {
  default = ""
}

variable "entity" {
  description = "AWS Region, e.g us-west-2"
}

variable "vpc_id" {
  description = "VPC ID"
}

variable "subnet_ids" {
  description = "A external subnet id"
  type        = "list"
}

variable "environment" {
  description = "Environment tag, e.g prod"
}
