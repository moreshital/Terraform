resource "aws_lb_target_group" "main" {
  name     = "${var.name}-tg"
  protocol = "TCP"
  port     = "${var.nlb_port}"
  vpc_id   = "${var.vpc_id}"

  
  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    port                = "traffic-port"
    protocol            = "TCP"
    interval            = 10
  }


}

resource "aws_lb_listener" "instance_listener-1" {
  load_balancer_arn = "${var.nlb_arn}"
  port              = "${var.nlb_port}"
  protocol          = "TCP"

  default_action {
    target_group_arn = "${aws_lb_target_group.main.arn}"
    type             = "forward"
  }
}
