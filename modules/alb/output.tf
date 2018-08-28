output "alb_name" {
  value = "${aws_alb.main.name}"
}

output "alb_arn" {
  value = "${aws_alb.main.arn}"
}

output "dns_name" {
  value = "${aws_alb.main.dns_name}"
}

output "alb_arn_suffix" {
  value = "${aws_alb.main.arn_suffix}"
}

output "alb_zone_id" {
  value = "${aws_alb.main.zone_id}"
}

output "id" {
  value = "${aws_alb.main.id}"
}