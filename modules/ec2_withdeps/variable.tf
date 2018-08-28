variable "instance_type" {
  default     = "t2.micro"
  description = "Instance type, see a list at: https://aws.amazon.com/ec2/instance-types/"
}

variable "name" {
  default = ""
}

variable "key_name" {
  default = ""
}

variable "private_ip" {
  default = ""
}

variable "region" {
  description = "AWS Region, e.g us-west-2"
}

variable "application" {
  default = ""
}

variable "application-type" {
  default = ""
}

variable "entity" {
  description = "AWS Region, e.g us-west-2"
}

variable "security_groups" {
  type = "list"
  description = "a comma separated lists of security group IDs"
}


variable "ami_id" {
  description = "VPC ID"
}

variable "subnet_id" {
  description = "A external subnet id"
}

variable "environment" {
  description = "Environment tag, e.g prod"
}

variable "associate_public_ip_address" {
  default = "false"
}
variable "userdata" {
  default = ""
}
variable "depends_on" {type = "list"}