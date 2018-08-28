variable "access_key" {
description = "Enter Access key id"
}
variable "secret_key" {
description = "Enter Secret key ID"
}

variable "aws_region" {description = "Enter Region where you want to create VPC"}
variable "vpc_cidr" { description = "Enter CIDR for VPC"}
variable "public_subnet_1_cidr" {description = "Enter CIDR of public subnet 1"}
variable "public_subnet_2_cidr" {description = "Enter CIDR of public subnet 2"}
variable "private_subnet_1_cidr" {description = "Enter CIDR of private subnet 1"}
variable "private_subnet_2_cidr" {description = "Enter CIDR of private subnet 2"}
