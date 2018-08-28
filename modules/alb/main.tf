resource "aws_alb" "main" {
  name                              = "${var.name}-alb"
  internal                          = "${var.internal_lb_value}"
  security_groups                   = ["${var.security_groups}"]
  enable_cross_zone_load_balancing  = "true"
  enable_http2                      = "true"
  subnets                           = ["${var.subnet_ids}"]
  #proxy_protocol_v2                 = "false"

  access_logs {
    bucket  = "${var.log_bucket}"
    prefix  = "elb-logs/${var.name}-alb-logs"
    enabled = "${var.environment == "Production" ? true : false }"
  }

  tags {
    "Entity"      = "${var.entity}"
    "Environment" = "${var.environment}"
    "Name"        = "${var.name}-alb"
  }
}
