resource "aws_cloudwatch_log_group" "log-group" {
  name = "${var.environment}-${var.log_group_name}"

  tags {
    Environment = "${var.environment}"
  }
}