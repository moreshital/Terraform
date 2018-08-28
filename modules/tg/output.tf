output "target_group_arn" {
  value = "${aws_alb_target_group.main.arn}"
}

output "target_group_name" {
  value = "${aws_alb_target_group.main.name}"
}

output "target_group_arn_suffix" {
  value = "${aws_alb_target_group.main.arn_suffix}"
}

output "target_listener443" {
  value = "${aws_alb_listener.instance_listener-1.id}"
}

output "target_listener80" {
  value = "${aws_alb_listener.instance_listener-2.id}"
}
