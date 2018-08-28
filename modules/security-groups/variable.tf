/**
 * Creates basic security groups to be used by instances and ELBs.
 */

variable "name" {
  description = "The name of the security groups serves as a prefix, e.g stack"
  default     = ""
}

variable "security_group" {
  default = ""
}

variable "http_port" {
  default = "80"
}

variable "https_port" {
  default = "443"
}

variable "jenkins_server" {
  default = ""
}

variable "ssh_port" {
  default = "22"
}

variable "ssh_access" {
  description = "A list of CIDR for ssh Access"

  #type = "list"
}

variable "rds_port" {
  default = "5432"
}

variable "vpc_id" {
  description = "The VPC ID"
}

variable "elasticache_port" {
  default = "6379"
}

variable "environment" {
  description = "The environment, used for tagging, e.g prod"
}

variable "cidr" {
  description = "The cidr block to use for internal security groups"
}

variable "elasticache_type" {
  default = "Redis"
}

variable "entity" {
  default = "Hooq"
}
