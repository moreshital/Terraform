output "r53_domain_name" {
	value = "${aws_route53_record.main.name}"
}