data "template_file" "main" {
  template = "${file("files/user_data/${var.userdata}")}"

  vars {
    cluster_name = "${var.name}-cluster"
  }
}

resource "aws_launch_configuration" "main" {
  name_prefix          = "${var.name}-lc-"
  key_name             = "${var.key_name}"
  iam_instance_profile = "${var.instance_role}"
  image_id             = "${var.ami_id}"
  instance_type        = "${var.instance_type}"
  security_groups      = ["${var.security_groups}"]
  user_data            = "${data.template_file.main.rendered}"

  lifecycle {
    create_before_destroy = true
  }
}

# The auto scaling group that specifies how we want to scale the number of EC2 Instances
resource "aws_autoscaling_group" "main" {
  name                 = "${var.name}-asg"
  availability_zones   = ["${var.availability_zones}"]
  vpc_zone_identifier  = ["${var.subnet_ids}"]
  launch_configuration = "${aws_launch_configuration.main.name}"
  min_size             = "${var.min_size}"
  max_size             = "${var.max_size}"
  desired_capacity     = "${var.desired_capacity}"
  health_check_type    = "EC2"
  enabled_metrics      = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
  termination_policies = ["OldestLaunchConfiguration", "Default"]
  target_group_arns    = ["${var.target_group_arn}"]

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "${var.name}-asg"
    propagate_at_launch = true
  }

  tag {
    key                 = "Entity"
    value               = "${var.entity}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = "${var.environment}"
    propagate_at_launch = true
  }

  tag {
    key                 = "application"
    value               = "${var.application}"
    propagate_at_launch = true
  }
}

resource "aws_ecs_cluster" "main" {
  name = "${var.name}-cluster"

  lifecycle {
    create_before_destroy = true
  }
}

# User data template that specifies how to bootstrap each instance
data "template_file" "container_definitions" {
  template = "${file("files/task-definitions/kong-loadtesting.json")}"

  vars {
    cluster_name         = "${var.name}"
    mount_path           = "${var.mount_path}"
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
    expression = "attribute:ecs.availability-zone in [ap-southeast-1a, ap-southeast-1b, ap-southeast-1c]"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_ecs_service" "main" {
  deployment_minimum_healthy_percent = "100"
  deployment_maximum_percent         = "200"
  iam_role                           = "ecsServiceRole"
  name                               = "${var.name}-service"
  desired_count                      = "${var.desired_count}"
  cluster                            = "${aws_ecs_cluster.main.id}"

  load_balancer {
    target_group_arn = "${var.target_group_arn}"
    container_name   = "${var.container_name}"
    container_port   = "${var.container_port}"
  }

  # Track the latest ACTIVE revision
  task_definition = "${aws_ecs_task_definition.main.family}:${max("${aws_ecs_task_definition.main.revision}")}"
}
