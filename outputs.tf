output "ingress_security_group_id" {
  value       = module.ec2.ingress_security_group_id
  description = "ID of the created ingress security group"
}
