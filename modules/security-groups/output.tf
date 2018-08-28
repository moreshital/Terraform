// External SSH allows ssh connections on port 22 from the world.
output "external_ssh" {
  value = "${aws_security_group.external_ssh.id}"
}

// Internal SSH allows ssh connections from the external ssh security group.
output "internal_ssh" {
  value = "${aws_security_group.internal_ssh.id}"
}

// Internal ELB allows internal traffic.
output "internal_elb" {
  value = "${aws_security_group.internal_elb.id}"
}

// External ELB allows traffic from the world.
output "external_elb" {
  value = "${aws_security_group.external_elb.id}"
}

// Internal Autoscaling allows internal traffic.
output "internal_autoscaling" {
  value = "${aws_security_group.internal_autoscaling.id}"
}

// External Autoscaling allows traffic from the world.
output "external_autoscaling" {
  value = "${aws_security_group.external_autoscaling.id}"
}

// Internal RDS allows internal traffic.
output "internal_rds" {
  value = "${aws_security_group.internal_rds.id}"
}

// Internal REDIS allows internal traffic.
output "internal_elasticache" {
  value = "${aws_security_group.internal_elasticache.id}"
}

output "internal_elasticsearch" {
  value = "${aws_security_group.internal_elasticsearch.id}"
}
