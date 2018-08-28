data "template_file" "main" {
  template = "${file("files/user_data/${var.userdata}")}"
}

resource "aws_instance" "main" {
  ami                    = "${var.ami_id}"
  source_dest_check      = false
  instance_type          = "${var.instance_type}"
  subnet_id              = "${var.subnet_id}"
  key_name               = "${var.key_name}"
  private_ip             = "${var.private_ip}"
  vpc_security_group_ids = ["${var.security_groups}"]
  monitoring             = true
  user_data              = "${data.template_file.main.rendered}"
  associate_public_ip_address = "${var.associate_public_ip_address}"

  tags {
    Name             = "${var.name}"
    Environment      = "${var.environment}"
    Entity           = "${var.entity}"
    Application      = "${var.application}"
  }
  depends_on = []
}
