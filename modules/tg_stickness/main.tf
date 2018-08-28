resource "aws_alb_target_group" "main" {
  name     = "${var.name}-tg"
  protocol = "HTTP"
  port     = "${var.alb_port}"
  vpc_id   = "${var.vpc_id}"
  stickiness {
    type = "lb_cookie"
    cookie_duration = "${var.cookie_duration}"
    enabled = true
  }
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

resource "aws_alb_listener" "instance_listener-1" {
  load_balancer_arn = "${var.alb_arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${var.cert_acm_arn}"

  default_action {
    target_group_arn = "${aws_alb_target_group.main.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "instance_listener-2" {
  load_balancer_arn = "${var.alb_arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.main.arn}"
    type             = "forward"
  }
}
