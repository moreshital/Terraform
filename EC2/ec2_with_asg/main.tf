data "aws_ami" "ami" {
  most_recent = true
  filter {
    name   = "name"
    values = ["${var.ami_name_pattern}"]
  }
  #name_regex = "${var.ami_name_regex}"
}



module "sg" {
  source = "../../../../modules/aws_sg"
  name        = "${var.security_groups_name}"
  description = "service security_groups"
  vpc_id      = "${var.vpc_id}"
  ingress_with_cidr_blocks = [
    {
      from_port   = "${var.tg_port}"
      to_port     = "${var.tg_port}"
      protocol    = "tcp"
      description = "service ports"
      cidr_blocks = "10.200.0.0/16"
    },
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      description = "ssh"
      cidr_blocks = "10.200.0.0/16"
    },
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      description = "ssh"
      cidr_blocks = "192.168.48.0/20"
    },
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      description = "ssh"
      cidr_blocks = "192.168.110.0/23"
    }
    ]
}




module "asg" {
  source               = "../../../../modules/asg_lc"
  name                 = "${var.service_name}"
  min_size             = "${var.min_size}"
  max_size             = "${var.max_size}"
  desired_capacity     = "${var.desired_capacity}"
  application          = "${var.application}"
  logrotate            = "Yes"
  userdata             = "${var.userdata}"
  entity               = "${var.entity}"
  region               = "${var.region}"
  environment          = "${var.environment}"
  availability_zones   = "${var.availability_zones}"
  vpc_id            = "${var.vpc_id}"
  subnet_ids        = "${var.app_private_subnet_ids}"
  security_groups  = ["${module.sg.security_group_id}", "${var.common_security_group}"]
  ami_id            = "${data.aws_ami.ami.id}"
  key_name          = "${var.key_name}"
  target_group_arn = [""]
  instance_type          = "${var.instance_type}"

}


module "elb" {
  source = "../../../../modules/elb-common"
  entity            = "${var.entity}"
  environment       = "${var.environment}"
  name              = "${var.service_name}"
  internal_lb_value = "${var.internal_status}"
  subnet_ids        = "${var.lb_private_subnet_ids}"
  instance_port  = "${var.instance_port}"
  instance_protocol = "${var.instance_protocol}"
  lb_port         = "${var.lb_port}"
  lb_protocol     = "${var.lb_protocol}"
  elb_healthcheck_path = "${var.elb_healthcheck_path}"
  security_groups   = ["${var.lb_private_security_group}"]
  cert_acm_arn     = "${var.cert_acm_arn}"
  log_bucket  = "${var.log_bucket}"
}

resource "aws_autoscaling_attachment" "asg_attachment_elb" {
  autoscaling_group_name = "${module.asg.asg_id}"
  elb                    = "${module.elb.id}"
  # depends_on = ["${module.asg}", "${module.elb}"]
}


# ### Internal LB config
# module "alb" {
#   source = "../../../../modules/alb"
#   entity            = "${var.entity}"
#   environment       = "${var.environment}"
#   name              = "${var.service_name}"
#   internal_lb_value = "true"
#   subnet_ids        = "${var.lb_private_subnet_ids}"
#   security_groups   = ["${var.lb_private_security_group}"]
#   log_bucket        = "${var.log_bucket}"
# }


# module "tg" {
#   source         = "../../../../modules/tg"
#   name           = "${var.service_name}"
#   http_code      = "200"
#   alb_port       = "${var.tg_port}"
#   alb_check_path = "${var.alb_healthcheck_path}"
#   entity         = "${var.entity}"
#   environment    = "${var.environment}"
#   # cert_acm_arn   = "${var.cert_acm_arn}"
#   alb_arn        = "${module.alb.alb_arn}"
#   vpc_id         = "${var.vpc_id}"
#   cert_acm_arn  = "${var.cert_acm_arn}"
# }


module "r53_record" {
  source = "../../../../modules/r53_records"
  zone_id = "${var.zone_id}"
  name = "${var.dns_record_name}"
  elb_dns_name = "${module.elb.dns_name}"
  elb_zone_id  = "${module.elb.elb_zone_id}"
}
