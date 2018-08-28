output "asg_name" {
  value = "${aws_autoscaling_group.main.name}"
}

output "asg_arn" {
  value = "${aws_autoscaling_group.main.arn}"
}

output "cluster_name" {
  value = "${aws_ecs_cluster.main.name}"
}

output "cluster_arn" {
  value = "${aws_ecs_cluster.main.arn}"
}

output "launchconfig_name" {
  value = "${aws_launch_configuration.main.name}"
}

output "ecs_service_name" {
  value = "${aws_ecs_service.main.name}"
}
