resource "aws_elb" "main" {
  name               = "${var.name}-elb"
  internal           = "${var.internal_lb_value}"
  subnets            = ["${var.subnet_ids}"]
  tags {
    "Entity"      = "${var.entity}"
    "Environment" = "${var.environment}"
    "Name"        = "${var.name}-elb"
  }
  security_groups = ["${var.security_groups}"]
  listener {
    instance_port      = "${var.instance_port}"
    instance_protocol  = "${var.instance_protocol}"
    lb_port            = "${var.lb_port}"
    lb_protocol        = "${var.lb_protocol}"
    #ssl_certificate_id = "${var.cert_acm_arn}"
  }
    security_groups = ["${var.security_groups}"]
  listener {
    instance_port      = "${var.instance_port}"
    instance_protocol  = "HTTP"
    lb_port            = "443"
    lb_protocol        = "HTTPS"
    ssl_certificate_id = "${var.cert_acm_arn}"
  }
    health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "${var.elb_healthcheck_path}"
    interval            = 30
  }
    access_logs {
    bucket  = "${var.log_bucket}"
    bucket_prefix  = "elb-logs/${var.name}-elb-logs"
    enabled = "${var.environment == "Production" ? true : false }"
  }
}