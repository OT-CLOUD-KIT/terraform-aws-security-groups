output "arn" {
  description = "Amazon Resource Name (ARN) of the security group"
  value       = module.sg_example.arn
}

output "id" {
  description = "IDs of the security groups"
  value       =  module.sg_example.id
}

output "name" {
  description = "Name of the security group"
  value       = module.sg_example.name
}