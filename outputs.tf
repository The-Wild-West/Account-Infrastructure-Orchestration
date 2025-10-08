output "vpc_id" {
  description = "id of the root account vpc"
  value       = aws_vpc.main.id
}

output "vpc_subnet_id" {
  description = "id of the main subnet"
  value       = aws_subnet.public_subnet.id
}

output "control_node_id" {
  description = "The Ansible control node instance id"
  value       = aws_instance.ansible_control_node.id
}