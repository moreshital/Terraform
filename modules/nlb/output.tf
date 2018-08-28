output "id" {
  value = "${aws_lb.main.id}"
}

output "nlb_arn" {
  value = "${aws_lb.main.arn}"
}

output "dns_name" {
  value = "${aws_lb.main.dns_name}"
}

output "nlb_name" {
  value = "${aws_lb.main.name}"
}

output "nlb_zone_id" {
  value = "${aws_lb.main.zone_id}"
}