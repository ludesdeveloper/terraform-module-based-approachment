output "eip_id" {
  value = [for i in aws_eip.eip : i.id]
}
