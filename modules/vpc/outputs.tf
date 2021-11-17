output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnet_id" {
  value = aws_subnet.subnet.id
}

output "network_interface_id" {
  value = aws_network_interface.network_interface.id
}
