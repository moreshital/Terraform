// A comma-separated list of subnet IDs.
output "lc_name" {
  value = "${aws_launch_configuration.main.name}"
}
