variable "tags" {
  description = "Tags of the security group"
  type        = map(string)
}

variable "name" {
  description = "Name of the security group"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the security group"
  type        = string
}

variable "aws_security_group_variables" {
  description = "A map of all security group variables"
  type = list(object({
    description = optional(string)
    aws_security_group_ingress = optional(list(object({
      description       = optional(string)
      from_port         = number
      to_port           = number
      protocol          = string
      cidr_blocks       = optional(list(string))
      security_groups   = optional(list(string))
      ipv6_cidr_blocks  = optional(list(string))
      prefix_list_ids   = optional(list(string))
      self              = optional(bool)
    })))
    aws_security_group_egress = optional(list(object({
      description       = optional(string)
      from_port         = number
      to_port           = number
      protocol          = string
      cidr_blocks       = optional(list(string))
      security_groups   = optional(list(string))
      ipv6_cidr_blocks  = optional(list(string))
      prefix_list_ids   = optional(list(string))
      self              = optional(bool)
    })))
  }))
}