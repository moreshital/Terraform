output "inst_id" {
  value = "${aws_instance.main.id}"
}

output "private_ip" {
  description = "private IP addresses assigned to the instances"
  value       = ["${aws_instance.main.private_ip}"]
}
