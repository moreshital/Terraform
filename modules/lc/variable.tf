variable "name" {
  description = "Launch Config name"
}

variable "instance_type" {
  description = "Instance type"
  default     = "t2.micro"
}

variable "key_name" {
  description = "SSH Key used for EC2"
  default     = ""
}

variable "security_groups" {
  type = "list"
}

variable "role_name" {
  description = "IAM Role Name"
  default     = ""
}

variable "userdata" {
  default = ""
}

variable "ami_id" {
  description = "AMI For Launch Config"
  default     = ""
}
