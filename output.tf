output "sg_id" {
  value = aws_security_group.security_group.id
  description = "Security group id"
}

output "sg_arn" {
  value = aws_security_group.security_group.arn
  description = "Security group arn"
}
