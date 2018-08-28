variable "region" {
  description = "The AWS region"
  default     = ""
}

variable "cidr" {
  description = "The CIDR block to provision for the VPC"
  default     = "10.30.0.0/16"
}

variable "s3_bucket" {
  default = ""
}

variable "backend_folder" {
  default = ""
}
