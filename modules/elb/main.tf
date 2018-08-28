resource "aws_elb" "main" {
  name                        = "${var.name}-elb"
  security_groups             = ["${var.security_groups}"]
  subnets                     = ["${var.subnet_ids}"]
  idle_timeout                = 60
  connection_draining_timeout = "${var.connection_drain_timeout}"
  cross_zone_load_balancing   = true
  connection_draining         = true

  internal                    = "${var.internal_status}"

  listener {
    instance_port      = "${var.instance_port1}"
    instance_protocol  = "${var.instance_protocol1}"
    lb_port            = "${var.lb_port1}"
    lb_protocol        = "${var.lb_protocol1}"
    #ssl_certificate_id = "${var.cert_acm_arn}"
  }
  listener {
    instance_port     = "${var.instance_port2}"
    instance_protocol = "${var.instance_protocol2}"
    lb_port           = "${var.lb_port2}"
    lb_protocol       = "${var.lb_protocol2}"
  }
  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 2
    interval            = 30
    target              = "${var.target_healthcheck}"
    timeout             = 5
  }
  tags {
    "Entity"      = "${var.entity}"
    "Application" = "${var.application}"
    "Environment" = "${var.environment}"
    "Name"        = "${var.name}-elb"
    "type"        = "${var.elb_type}"
  }
}
