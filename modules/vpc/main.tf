/**
 * VPC
 */

resource "aws_vpc" "main" {
  cidr_block           = "${var.cidr}"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    "Name"        = "${var.vpc_name}"
    "Environment" = "${var.environment}"
    "Entity"      = "${var.entity}"
    "ManagedBy"   = "CloudCover"
  }
}

/**
 * Gateways
 */

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name        = "${var.vpc_name}-gw"
    Environment = "${var.environment}"
  }
}

resource "aws_eip" "nat-ip" {
  vpc        = true
  depends_on = ["aws_internet_gateway.main"]
  vpc        = true
}

resource "aws_nat_gateway" "main" {
  allocation_id = "${aws_eip.nat-ip.id}"
  subnet_id     = "${aws_subnet.aws-public-subnet1.id}"
  subnet_id     = "${element(aws_subnet.external.*.id, count.index)}"
  depends_on    = ["aws_internet_gateway.main"]

  tags {
    Name = "${var.vpc_name}-nat-gw"
  }
}

/**
 * Subnets.
 */

resource "aws_subnet" "internal" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${element(var.internal_subnets, count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"
  count             = "${length(var.internal_subnets)}"

  tags {
    Name        = "${var.vpc_name}-${format("internal-%03d", count.index+1)}-subnet"
    Environment = "${var.environment}"
  }
}

resource "aws_subnet" "rds" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${element(var.rds_subnets, count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"
  count             = "${length(var.rds_subnets)}"

  tags {
    Name        = "${var.vpc_name}-${format("rds-%03d", count.index+1)}-subnet"
    Environment = "${var.environment}"
  }
}

resource "aws_subnet" "elasticache" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${element(var.elasticache_subnets, count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"
  count             = "${length(var.elasticache_subnets)}"

  tags {
    Environment = "${var.environment}"
    Name        = "${var.vpc_name}-${format("elasticache-%03d", count.index+1)}-subnet"
  }
}

resource "aws_subnet" "external" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${element(var.external_subnets, count.index)}"
  availability_zone       = "${element(var.availability_zones, count.index)}"
  count                   = "${length(var.external_subnets)}"
  map_public_ip_on_launch = true

  tags {
    Name        = "${var.vpc_name}-${format("external-%03d", count.index+1)}-subnet"
    Environment = "${var.environment}"
  }
}

/**
 * Route tables
 */

resource "aws_route_table" "external" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name        = "${var.vpc_name}-external-001-rt"
    Environment = "${var.environment}"
  }
}

resource "aws_route" "external" {
  route_table_id         = "${aws_route_table.external.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.main.id}"
}

resource "aws_route_table" "internal" {
  count  = "${length(var.internal_subnets)}"
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name        = "${var.vpc_name}-${format("internal-%03d", count.index+1)}-rt"
    Environment = "${var.environment}"
  }
}

resource "aws_route" "internal" {
  # Create this only if using the NAT gateway service, vs. NAT instances.
  count                  = "${(1 - var.use_nat_instances) * length(compact(var.internal_subnets))}"
  route_table_id         = "${element(aws_route_table.internal.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.main.*.id, count.index)}"
}

/**
 * Route associations
 */

resource "aws_route_table_association" "internal" {
  count          = "${length(var.internal_subnets)}"
  subnet_id      = "${element(aws_subnet.internal.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.internal.*.id, count.index)}"
}

resource "aws_route_table_association" "external" {
  count          = "${length(var.external_subnets)}"
  subnet_id      = "${element(aws_subnet.external.*.id, count.index)}"
  route_table_id = "${aws_route_table.external.id}"
}
