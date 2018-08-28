data "template_file" "main" {
  template = "${file("files/user_data/app-server.sh")}"

  vars {
    name = "${var.name}"
  }
}
