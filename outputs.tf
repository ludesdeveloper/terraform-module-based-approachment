output "security_group_id" {
  value       = module.ec2.security_group_id
  description = "ID of the created ingress security group"
}
