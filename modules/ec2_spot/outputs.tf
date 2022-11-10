output "instance_id" {
  value = [for i in aws_spot_instance_request.instance : i.spot_instance_id]
}
