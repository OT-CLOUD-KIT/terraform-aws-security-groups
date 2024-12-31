output "arn" {
  description = "Amazon Resource Name (ARN) of the security group"
  value       = [for sg in aws_security_group.sg : sg.arn]
}

output "id" {
  description = "IDs of the security groups"
  value       = [for sg in aws_security_group.sg : sg.id]
}

output "name" {
  description = "Name of the security group"
  value       = [for sg in aws_security_group.sg : sg.name]
}

output "sg_ingress" {
  description = "Ingress of the security group"
  value       = [for sg in aws_security_group.sg : sg.ingress]
}

output "sg_egress" {
  description = "Egress of the security group"
  value       = [for sg in aws_security_group.sg : sg.egress]
}