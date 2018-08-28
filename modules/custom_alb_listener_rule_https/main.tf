
resource "aws_alb_listener" "main" {
  load_balancer_arn = "${var.alb_arn}"
  port              = "${var.port}"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${var.cert_acm_arn}"

  default_action {
    target_group_arn = "${var.target_group_arn}"
    type             = "forward"
  }
}

