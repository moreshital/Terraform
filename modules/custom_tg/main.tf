resource "aws_alb_target_group" "main" {
  name     = "${var.name}-tg"
  protocol = "HTTP"
  port     = "${var.alb_port}"
  vpc_id   = "${var.vpc_id}"

  health_check {
    healthy_threshold   = "5"
    unhealthy_threshold = "2"
    timeout             = "5"
    interval            = "30"
    matcher             = "${var.http_code}"
    path                = "${var.alb_check_path}"
  }
  tags {
    Environment = "${var.environment}"
  }
}

