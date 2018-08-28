output "elb_name" {
  value = "${aws_elb.main.name}"
}

output "dns_name" {
  value = "${aws_elb.main.dns_name}"
}

output "elb_id" {
  value = "${aws_elb.main.id}"
}

output "zone_id" {
  value = "${aws_elb.main.zone_id}"
}
