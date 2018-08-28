output "id" {
  value = "${aws_elb.main.id}"
}

output "elb_arn" {
  value = "${aws_elb.main.arn}"
}

output "dns_name" {
  value = "${aws_elb.main.dns_name}"
}

output "elb_name" {
  value = "${aws_elb.main.name}"
}

output "elb_zone_id" {
  value = "${aws_elb.main.zone_id}"
}