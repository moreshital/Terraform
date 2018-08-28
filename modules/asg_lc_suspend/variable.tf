variable "name" {
  default = ""
}

variable "region" {
  description = "AWS Region, e.g us-west-2"
}

variable "launch_configuration" {
  default = ""
}

variable "target_group_arn" {
  type = "list"
}

variable "desired_capacity" {
  default = "2"
}

variable "application-type" {
  default = ""
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

variable "logrotate" {
  description = "for s3 logrotate yes/no"
}

variable depends_on { default = [], type = "list"}

variable "instance_type" {
  description = "Instance type"
}

variable "key_name" {
  description = "SSH Key used for EC2"
  default     = ""
}

variable "security_groups" {
  type = "list"
}

variable "role_arn" {
  description = "IAM Role profile"
  default     = "arn:aws:iam::901680736066:instance-profile/appLogging"
}

variable "userdata" {
  default = ""
}

variable "ami_id" {
  description = "AMI For Launch Config"
  default     = ""
}
