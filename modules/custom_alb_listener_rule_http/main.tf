
resource "aws_alb_listener" "main" {
  load_balancer_arn = "${var.alb_arn}"
  port              = "${var.port}"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${var.target_group_arn}"
    type             = "forward"
  }
}

