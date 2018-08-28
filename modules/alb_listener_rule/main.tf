resource "aws_lb_listener_rule" "main80" {
  listener_arn = "${var.target_listener80}"
  priority     = "${var.priority}"

  action {
    type             = "forward"
    target_group_arn = "${var.target_group_arn}"
  }

}

resource "aws_lb_listener_rule" "main443" {
  listener_arn = "${var.target_listener443}"
  priority     = "${var.priority}"

  action {
    type             = "forward"
    target_group_arn = "${var.target_group_arn}"
  }
}
