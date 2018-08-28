variable "name" {
  default = ""
}

variable "desired_count" {
  default = ""
}

variable "region" {
  description = "AWS Region, e.g us-west-2"
}

variable "target_group_arn" {
  default = ""
}

variable "volume_name" {
  default = ""
}

variable "container_mount_path" {
  default = ""
}

variable "instance_type" {
  default = ""
}

variable "container_name" {
  default = ""
}

variable "container_port" {
  default = ""
}

variable "instance_role" {
  default = ""
}

variable "key_name" {
  default = ""
}

variable "instance_volume_path" {
  default = ""
}

variable "userdata" {
  default = ""
}

variable "desired_capacity" {
  default = "1"
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

variable "environment" {
  description = "Environment tag, e.g prod"
}

variable "docker_image" {
  default = ""
}

variable "docker_tag" {
  default = ""
}

variable "awslogs_group" {
  default = ""
}

variable "host_port" {
  default = ""
}

variable "cluster_name" {
  default = ""
}

variable "container_definition_file" {
  default = ""
}

variable "max_capacity" {
  default = ""
}

variable "min_capacity" {
  default = ""
}

variable "ecs_iam_role" {
  default = ""
}

variable "ecs_target_name" {
  default = ""
}

variable "aws_loggroup_condition" {
}
