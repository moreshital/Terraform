data "template_file" "main" {
  template = "${file("files/user_data/${var.userdata}")}"
  #template = "${file("${var.userdata}")}"
}

resource "aws_launch_configuration" "main" {
  name         = "${var.name}-lc"
  instance_type        = "${var.instance_type}"
  key_name             = "${var.key_name}"
  iam_instance_profile = "${var.role_name}"
  security_groups      = ["${var.security_groups}"]
  image_id             = "${var.ami_id}"

  user_data = "${data.template_file.main.rendered}"

  lifecycle {
    create_before_destroy = false
  }
}
