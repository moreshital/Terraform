resource "aws_security_group" "internal_elb" {
  name        = "${format("%s-%s-internal-elb-sg", var.entity, var.environment)}"
  vpc_id      = "${var.vpc_id}"
  description = "Allows internal ELB traffic"

  ingress {
    from_port   = "${var.http_port}"
    to_port     = "${var.http_port}"
    protocol    = "tcp"
    cidr_blocks = ["${var.cidr}"]
  }

  ingress {
    from_port   = "${var.https_port}"
    to_port     = "${var.https_port}"
    protocol    = "tcp"
    cidr_blocks = ["${var.cidr}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags {
    "ManagedBy" = "CloudCover"
    "Entity"    = "${var.entity}"
    Name        = "${format("%s-%s-internal-elb-sg", var.entity, var.environment)}"
    Environment = "${var.environment}"
  }
}

resource "aws_security_group" "external_elb" {
  name        = "${format("%s-%s-external-elb-sg", var.entity, var.environment)}"
  vpc_id      = "${var.vpc_id}"
  description = "Allows external ELB traffic"

  ingress {
    from_port   = "${var.http_port}"
    to_port     = "${var.http_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "${var.https_port}"
    to_port     = "${var.https_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags {
    "ManagedBy" = "CloudCover"
    "Entity"    = "${var.entity}"
    Name        = "${format("%s-%s-external-elb-sg", var.entity, var.environment)}"
    Environment = "${var.environment}"
  }
}

resource "aws_security_group" "external_ssh" {
  name        = "${format("%s-%s-external-ssh-sg", var.entity, var.environment)}"
  description = "Allows ssh from the world"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = "${var.ssh_port}"
    to_port     = "${var.ssh_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags {
    "ManagedBy" = "CloudCover"
    "Entity"    = "${var.entity}"
    Name        = "${format("%s-%s-external-ssh-sg", var.entity, var.environment)}"
    Environment = "${var.environment}"
    "meltdown"  = "pending"
  }
}

resource "aws_security_group" "internal_ssh" {
  name        = "${format("%s-%s-internal-ssh-sg", var.entity, var.environment)}"
  description = "Allows ssh For EC2 Instance"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = "${var.ssh_port}"
    to_port     = "${var.ssh_port}"
    protocol    = "tcp"
    cidr_blocks = ["${split(",", var.ssh_access)}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["${var.cidr}"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags {
    "ManagedBy" = "CloudCover"
    "Entity"    = "${var.entity}"
    Name        = "${format("%s-%s-internal-ssh-sg", var.entity, var.environment)}"
    Environment = "${var.environment}"
    "meltdown"  = "pending"
  }
}


resource "aws_security_group" "external_autoscaling" {
  name        = "${format("%s-%s-external-autoscaling-sg", var.entity, var.environment)}"
  description = "Security group for ${var.entity}"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = "${var.http_port}"
    to_port     = "${var.http_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "${var.https_port}"
    to_port     = "${var.https_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "${var.ssh_port}"
    to_port     = "${var.ssh_port}"
    protocol    = "tcp"
    cidr_blocks = ["${split(",", var.ssh_access)}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    "ManagedBy"   = "CloudCover"
    "Name"        = "${format("%s-%s-external-autoscaling-sg", var.entity, var.environment)}"
    "Environment" = "${var.environment}"
    "Entity"      = "${var.entity}"
    "meltdown"    = "pending"
  }
}

resource "aws_security_group" "internal_autoscaling" {
  name        = "${format("%s-%s-internal-autoscaling-sg", var.entity, var.environment)}"
  description = "app security group for ${var.entity}"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = "${var.http_port}"
    to_port     = "${var.http_port}"
    protocol    = "tcp"
    cidr_blocks = ["${var.cidr}"]
  }

  ingress {
    from_port   = "8000"
    to_port     = "8000"
    protocol    = "tcp"
    cidr_blocks = ["${var.cidr}"]
  }

  ingress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["${var.cidr}"]
  }

  ingress {
    from_port   = "${var.https_port}"
    to_port     = "${var.https_port}"
    protocol    = "tcp"
    cidr_blocks = ["${var.cidr}"]
  }

  ingress {
    from_port   = "${var.ssh_port}"
    to_port     = "${var.ssh_port}"
    protocol    = "tcp"
    cidr_blocks = ["${split(",", var.ssh_access)}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    "ManagedBy"   = "CloudCover"
    "Name"        = "${format("%s-%s-internal-autoscaling-sg", var.entity, var.environment)}"
    "Environment" = "${var.environment}"
    "Entity"      = "${var.entity}"
    "meltdown"    = "pending"
  }
}

## RDS SG
resource "aws_security_group" "internal_rds" {
  name        = "${format("%s-%s-internal-rds-sg", var.entity, var.environment)}"
  description = "RDS Security group for ${var.entity}"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = "${var.rds_port}"
    to_port     = "${var.rds_port}"
    protocol    = "tcp"
    cidr_blocks = ["${var.cidr}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    "ManagedBy"   = "CloudCover"
    "Name"        = "${format("%s-%s-internal-rds-sg", var.entity, var.environment)}"
    "Environment" = "${var.environment}"
    "Entity"      = "${var.entity}"
  }
}

## elasticache SG

resource "aws_security_group" "internal_elasticache" {
  name        = "${format("%s-%s-internal-elasticache-sg", var.entity, var.environment)}"
  description = "elasticsearch security group for ${var.entity}"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = "${var.elasticache_port}"
    to_port     = "${var.elasticache_port}"
    protocol    = "tcp"
    cidr_blocks = ["${var.cidr}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    "ManagedBy"   = "CloudCover"
    "Entity"      = "${var.entity}"
    "Type"        = "${var.elasticache_type}"
    "Name"        = "${format("%s-%s-elasticcache-sg", var.entity, var.environment)}"
    "Environment" = "${var.environment}"
    "meltdown"    = "pending"
  }
}

## elasticsearch SG

resource "aws_security_group" "internal_elasticsearch" {
  name        = "${format("%s-%s-internal-elasticsearch-sg", var.entity, var.environment)}"
  description = "elasticsearch security group for ${var.entity}"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = "9200"
    to_port     = "9200"
    protocol    = "tcp"
    cidr_blocks = ["${var.cidr}"]
  }

  ingress {
    from_port   = "9300"
    to_port     = "9300"
    protocol    = "tcp"
    cidr_blocks = ["${var.cidr}"]
  }

  ingress {
    from_port   = "${var.ssh_port}"
    to_port     = "${var.ssh_port}"
    protocol    = "tcp"
    cidr_blocks = ["${split(",", var.ssh_access)}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    "ManagedBy"   = "CloudCover"
    "Entity"      = "${var.entity}"
    "Name"        = "${format("%s-%s-elasticsearch-sg", var.entity, var.environment)}"
    "Environment" = "${var.environment}"
    "meltdown"    = "pending"
  }
}
