output "vpc_id" {
  description = "id of the root account vpc"
  value       = aws_vpc.main.id
}

output "vpc_subnet_id" {
  description = "id of the main subnet"
  value       = aws_subnet.public_subnet.id
}
