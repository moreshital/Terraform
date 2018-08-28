variable "name" {
  description = "Launch Config name"
  default     = ""
}

variable "environment" {
  default = ""
}

variable "entity" {
  default = ""
}

variable "port" {
  default = ""
}

variable "subnet_ids" {
  description = "A list of subnet IDs"
  type        = "list"
}

variable "security_groups" {
  default = ""
}

variable "parameter_group_name" {
  description = "Instance type"
  default     = "list"
}

variable "num_cache_nodes" {
  description = "SSH Key used for EC2"
  default     = ""
}

variable "engine_version" {
  description = "IAM Role Name"
  default     = ""
}

variable "engine" {
  description = "ELB Accessiblity type"
  default     = ""
}
