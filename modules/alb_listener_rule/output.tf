output "listener_rule_80_arn" {
  value = "${aws_lb_listener_rule.main80.arn}"
}

output "listener_rule_443_arn" {
  value = "${aws_lb_listener_rule.main443.arn}"
}
