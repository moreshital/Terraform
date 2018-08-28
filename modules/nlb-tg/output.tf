output "target_group_arn" {
  value = "${aws_lb_target_group.main.arn}"
}

output "target_listern1" {
  value = "${aws_lb_listener.instance_listener-1.id}"
}

output "target_group_name" {
  value = "${aws_lb_target_group.main.name}"
}