variable "name" {
  description = "RDS instance name"
}

variable "subnet_ids" {
  description = "A list of subnet IDs"
  type        = "list"
}
