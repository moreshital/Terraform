data "aws_ami" "ami" {
  most_recent = true
  #executable_users = ["self"]
  filter {
    name   = "name"
    values = ["prod.ec2-service*"]
  }

}

module "sg" {
  source = "../../../../modules/aws_sg"
  name        = "${var.security_groups_name}"
  description = "ec2-service security_groups for ec2"
  vpc_id      = "${var.vpc_id}"
  ingress_with_cidr_blocks = [
    {
      from_port   = 8443
      to_port     = 8443
      protocol    = "tcp"
      description = "ec2-service ports"
      cidr_blocks = "10.200.0.0/16"
    },
    {
      from_port   = 0
      to_port     = 65000
      protocol    = "tcp"
      description = "ec2-service ports"
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

module "sgalb" {
  source = "../../../../modules/aws_sg"
  name        = "${var.albsecurity_groups_name}"
  description = "ec2-service security_groups"
  vpc_id      = "${var.vpc_id}"
  ingress_with_cidr_blocks = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "ec2-service ports"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "ec2-service ports"
      cidr_blocks = "0.0.0.0/0"
    }
    ]
}

module "ec2-service-1" {
  source           = "../../../../modules/ec2"
  instance_type    = "${var.instance_type}"
  ami_id          = "${data.aws_ami.ami.id}"
  application      = "platform"
  region           = "${var.region}"
  entity           = "${var.entity}"
  key_name         = "${var.key_name}"
  environment      = "${var.environment}"
  name             = "${var.service_name}-1"
  security_groups  = ["${module.sg.security_group_id}", "${var.common_security_group}"]
  subnet_id        = "${var.subnet_id}"
  userdata         = "${var.userdata}"
}

module "ec2-service-2" {
  source           = "../../../../modules/ec2"
  instance_type    = "${var.instance_type}"
  ami_id          = "${data.aws_ami.ami.id}"
  application      = "platform"
  region           = "${var.region}"
  entity           = "${var.entity}"
  key_name         = "${var.key_name}"
  environment      = "${var.environment}"
  name             = "${var.service_name}-2"
  security_groups  = ["${module.sg.security_group_id}", "${var.common_security_group}"]
  subnet_id        = "${var.subnet_id}"
  userdata         = "${var.userdata}"
}

module "ec2-service-3" {
  source           = "../../../../modules/ec2"
  instance_type    = "${var.instance_type}"
  ami_id          = "${data.aws_ami.ami.id}"
  application      = "platform"
  region           = "${var.region}"
  entity           = "${var.entity}"
  key_name         = "${var.key_name}"
  environment      = "${var.environment}"
  name             = "${var.service_name}-3"
  security_groups  = ["${module.sg.security_group_id}", "${var.common_security_group}"]
  subnet_id        = "${var.subnet_id}"
  userdata         = "${var.userdata}"
}

module "ec2-service-4" {
  source           = "../../../../modules/ec2"
  instance_type    = "${var.instance_type}"
  ami_id          = "${data.aws_ami.ami.id}"
  application      = "platform"
  region           = "${var.region}"
  entity           = "${var.entity}"
  key_name         = "${var.key_name}"
  environment      = "${var.environment}"
  name             = "${var.service_name}-4"
  security_groups  = ["${module.sg.security_group_id}", "${var.common_security_group}"]
  subnet_id        = "${var.subnet_id}"
  userdata         = "${var.userdata}"
}

module "ec2-service-5" {
  source           = "../../../../modules/ec2"
  instance_type    = "${var.instance_type}"
  ami_id          = "${data.aws_ami.ami.id}"
  application      = "platform"
  region           = "${var.region}"
  entity           = "${var.entity}"
  key_name         = "${var.key_name}"
  environment      = "${var.environment}"
  name             = "${var.service_name}-5"
  security_groups  = ["${module.sg.security_group_id}", "${var.common_security_group}"]
  subnet_id        = "${var.subnet_id}"
  userdata         = "${var.userdata}"
}


module "alb" {
  source = "../../../../modules/alb"
  entity            = "${var.entity}"
  environment       = "${var.environment}"
  name              = "${var.service_name}"
  internal_lb_value = "true"
  subnet_ids        = "${var.lb_public_subnet_ids}"
  security_groups   = ["${var.lb_public_security_group}"]
  log_bucket        = "${var.log_bucket}"
}


module "tg" {
  source         = "../../../../modules/tg"
  name           = "${var.service_name}"
  http_code      = "200"
  alb_port       = "${var.tg_port}"
  alb_check_path = "${var.alb_healthcheck_path}"
  entity         = "${var.entity}"
  environment    = "${var.environment}"
  # cert_acm_arn   = "${var.cert_acm_arn}"
  alb_arn        = "${module.alb.alb_arn}"
  vpc_id         = "${var.vpc_id}"
  cert_acm_arn  = "${var.cert_acm_arn}"
}



resource "aws_lb_target_group_attachment" "ec2-service1" {
  target_group_arn = "${module.tg.target_group_arn}"
  target_id        = "${module.ec2-service-1.inst_id}"
  port             = 8080
}
resource "aws_lb_target_group_attachment" "ec2-service2" {
  target_group_arn = "${module.tg.target_group_arn}"
  target_id        = "${module.ec2-service-2.inst_id}"
  port             = 8080
}
resource "aws_lb_target_group_attachment" "ec2-service3" {
  target_group_arn = "${module.tg.target_group_arn}"
  target_id        = "${module.ec2-service-3.inst_id}"
  port             = 8080

}
resource "aws_lb_target_group_attachment" "ec2-service4" {
  target_group_arn = "${module.tg.target_group_arn}"
  target_id        = "${module.ec2-service-4.inst_id}"
  port             = 8080
}
resource "aws_lb_target_group_attachment" "ec2-service5" {
  target_group_arn = "${module.tg.target_group_arn}"
  target_id        = "${module.ec2-service-5.inst_id}"
  port             = 8080
}
resource "aws_route53_record" "ec2-service1" {
  zone_id = "Z2IDUVEAXXXXXX"
  name    = "ec2-service-1.xyz.com"
  type    = "A"
  ttl     = "300"
  records = ["${module.ec2-service-1.private_ip}"]
}
resource "aws_route53_record" "ec2-service2" {
  zone_id = "Z2IDUVEAXXXXXX"
  name    = "ec2-service-2.xyz.com"
  type    = "A"
  ttl     = "300"
  records = ["${module.ec2-service-2.private_ip}"]
}
resource "aws_route53_record" "ec2-service3" {
  zone_id = "Z2IDUVEAXXXXXX"
  name    = "ec2-service-3.xyz.com"
  type    = "A"
  ttl     = "300"
  records = ["${module.ec2-service-3.private_ip}"]
}
resource "aws_route53_record" "ec2-service4" {
  zone_id = "Z2IDUVEAXXXXXX"
  name    = "ec2-service-4.xyz.com"
  type    = "A"
  ttl     = "300"
  records = ["${module.ec2-service-4.private_ip}"]
}
resource "aws_route53_record" "ec2-service5" {
  zone_id = "Z2IDUVEAXXXXXX"
  name    = "ec2-service-5.xyz.com"
  type    = "A"
  ttl     = "300"
  records = ["${module.ec2-service-5.private_ip}"]
}
module "r53_record" {
  source = "../../../../modules/r53_records"
  zone_id = "${var.zone_id}"
  name = "${var.dns_record_name}"
  elb_dns_name = "${module.alb.dns_name}"
  elb_zone_id  = "${module.alb.alb_zone_id}"
}
