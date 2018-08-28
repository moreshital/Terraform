output "target_group_arn" {
  value = "${aws_alb_target_group.main.arn}"
}

output "target_group_name" {
  value = "${aws_alb_target_group.main.name}"
}

output "target_group_arn_suffix" {
  value = "${aws_alb_target_group.main.arn_suffix}"
}

