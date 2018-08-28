output "asg_name" {
  value = "${aws_autoscaling_group.main.name}"
}

output "asg_arn" {
  value = "${aws_autoscaling_group.main.arn}"
}


output "asg_id" {
  value = "${aws_autoscaling_group.main.id}"
}
