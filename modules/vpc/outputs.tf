output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "private_subnet_id" {
  value = [for i in aws_subnet.private_subnet : i.id]
}

output "public_subnet_id" {
  value = [for i in aws_subnet.public_subnet : i.id]
}

output "internet_gateway" {
  value = aws_internet_gateway.internet_gateway
}
