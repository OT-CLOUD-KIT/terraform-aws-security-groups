output "sg_id" {
  value       = var.security_group_id == null ? aws_security_group.security_group[0].id : var.security_group_id
  description = "Security group id"
}

output "sg_arn" {
  value       = var.security_group_id == null ? aws_security_group.security_group[0].arn : null
  description = "Security group arn"
}
