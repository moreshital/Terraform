resource "aws_cloudwatch_log_group" "main" {
    count             = "${var.aws_loggroup_condition}"
    name              = "${var.awslogs_group}"
    retention_in_days = 365
  }


# User data template that specifies how to bootstrap each instance
data "template_file" "container_definitions" {
  template = "${file("files/task-definitions/${var.container_definition_file}")}"

  vars {
    cluster_name         = "${var.cluster_name}"
    mount_path           = "${var.container_mount_path}"  
    mount_path_name      = "${var.volume_name}"
    container_port       = "${var.container_port}"
    awslogs_group        = "${var.awslogs_group}"
    docker_tag           = "${var.docker_tag}"
    docker_image         = "${var.docker_image}"
    region               = "${var.region}"
    host_port            = "${var.host_port}"
    container_name       = "${var.container_name}"
    instance_volume_path = "${var.instance_volume_path}"
    volume_name          = "${var.volume_name}"
  }
}

resource "aws_ecs_task_definition" "main" {
  family                = "${var.name}-td"
  container_definitions = "${data.template_file.container_definitions.rendered}"

  volume {
    name      = "${var.volume_name}"
    host_path = "${var.instance_volume_path}"
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [${var.availability_zones[0]}, ${var.availability_zones[1]}, ${var.availability_zones[2]}]"
  }

  lifecycle {
    create_before_destroy = true
  }
}

### ECS Service
resource "aws_ecs_service" "main" {
  deployment_minimum_healthy_percent = "100"
  deployment_maximum_percent         = "200"
  iam_role                           = "arn:aws:iam::336296984562:role/ecsServiceRole"
  name                               = "${var.name}-service"
  desired_count                      = "${var.desired_count}"
  cluster                            = "${var.cluster_name}"

  load_balancer {
    target_group_arn = "${var.target_group_arn}"
    container_name   = "${var.container_name}"
    container_port   = "${var.container_port}"
  }

  # Track the latest ACTIVE revision
  task_definition = "${aws_ecs_task_definition.main.family}:${max("${aws_ecs_task_definition.main.revision}")}"
}

### ECS Service ASG
resource "aws_appautoscaling_target" "target" {
  service_namespace  = "ecs"
  role_arn           = "${var.ecs_iam_role}"
  min_capacity       = "${var.min_capacity}"
  max_capacity       = "${var.max_capacity}"
  scalable_dimension = "ecs:service:DesiredCount"
  resource_id        = "service/${var.cluster_name}/${var.name}-service"

  depends_on = ["aws_ecs_service.main"]

}
