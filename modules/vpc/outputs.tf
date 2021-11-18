output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnet_id" {
  value = [for i in aws_subnet.subnet : i.id]
}
