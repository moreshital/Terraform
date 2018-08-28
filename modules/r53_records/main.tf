resource "aws_route53_record" "main" {
  zone_id = "${var.zone_id}"
  name    = "${var.name}"
  type    = "A"

  alias {
    name                   = "${var.elb_dns_name}"
    zone_id                = "${var.elb_zone_id}"
    evaluate_target_health = false
  }
}