resource "aws_db_subnet_group" "main" {
  name        = "${var.name}-subnet-group"
  description = "RDS subnet group"
  subnet_ids  = ["${var.subnet_ids}"]

  tags {
    Name              = "${var.name}"
    Entity            = "${var.entity}"
    Application       = "${var.application}"
    Environment       = "${var.environment}"
    ManagedBy         = "${var.managedby}"
    CreatedBy         = "${var.createdby}"
    Sub-Environment   = "${var.sub-environment}"
    Application-Team  = "${var.application-team}"
  }
}

resource "aws_db_instance" "main" {
  identifier = "${var.name}"

  # Database
  engine         = "${var.engine}"
  engine_version = "${var.engine_version}"
  username       = "${coalesce(var.username, var.name)}"
  password       = "${var.password}"
  multi_az       = "${var.multi_az}"
  name           = "${coalesce(var.database, var.name)}"

  # Backups / maintenance
  backup_retention_period   = "${var.backup_retention_period}"
  backup_window             = "${var.backup_window}"
  maintenance_window        = "${var.maintenance_window}"
  monitoring_interval       = "${var.monitoring_interval}"
  monitoring_role_arn       = "${var.monitoring_role_arn}"
  apply_immediately         = "${var.apply_immediately}"
  final_snapshot_identifier = "${var.name}-finalsnapshot"
  snapshot_identifier       = "${var.snapshot_identifier}"

  # Hardware
  instance_class    = "${var.instance_class}"
  storage_type      = "${var.storage_type}"
  allocated_storage = "${var.allocated_storage}"

  # Network / security
  db_subnet_group_name   = "${aws_db_subnet_group.main.id}"
  vpc_security_group_ids = ["${var.security_groups}"]
  publicly_accessible    = "${var.publicly_accessible}"

  tags {
    Name              = "${var.name}"
    Entity            = "${var.entity}"
    Application       = "${var.application}"
    Environment       = "${var.environment}"
    ManagedBy         = "${var.managedby}"
    CreatedBy         = "${var.createdby}"
    Sub-Environment   = "${var.sub-environment}"
    Application-Team  = "${var.application-team}"
  }
}
