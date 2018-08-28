resource "aws_lb" "main" {
  load_balancer_type = "network"
  name               = "${var.name}-nlb"
  internal           = "${var.internal_lb_value}"
  subnets            = ["${var.subnet_ids}"]
  enable_cross_zone_load_balancing = "true"
  tags {
    "Entity"      = "${var.entity}"
    "Environment" = "${var.environment}"
    "Name"        = "${var.name}-nlb"
  }
}
