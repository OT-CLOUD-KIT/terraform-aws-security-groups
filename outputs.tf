output "web_security_group_id" {
  description = "The web_security_group_id of the VPC"
  value       = aws_security_group.web_sg.id
}

output "ssh_security_group_id" {
  description = "The ssh_security_group_id to whitelist ip in the VPC"
  value       = aws_security_group.ssh_sg.id
}
