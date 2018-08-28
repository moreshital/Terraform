resource "aws_db_subnet_group" "main" {
  name        = "${var.name}-subnet-group"
  description = "RDS subnet group"
  subnet_ids  = ["${var.subnet_ids}"]
}
