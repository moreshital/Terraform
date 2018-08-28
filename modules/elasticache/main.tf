resource "aws_elasticache_subnet_group" "main" {
  name        = "${var.name}-subnet-group"
  description = "RDS subnet group"
  subnet_ids  = ["${var.subnet_ids}"]
}

resource "aws_elasticache_cluster" "aws-redis1" {
  cluster_id = "${var.name}"
  engine     = "${var.engine}"

  #node_type            = "${var.node_type}"
  node_type            = "cache.t2.small"
  engine_version       = "${var.engine_version}"
  port                 = "${var.port}"
  num_cache_nodes      = "${var.num_cache_nodes}"
  security_group_ids   = ["${var.security_groups}"]
  subnet_group_name    = "${aws_elasticache_subnet_group.main.name}"
  parameter_group_name = "${var.parameter_group_name}"
}
