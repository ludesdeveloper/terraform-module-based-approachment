output "security_group_id" {
  value       = module.security_group.security_group_id
  description = "ID of the created ingress security group"
}
