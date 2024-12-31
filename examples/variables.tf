# ------------------------------------------------------------
# naming conventions variables
# ------------------------------------------------------------
variable "env" {
  description = "name of the environment"
  type        = string
}

variable "bu" {
  description = "name of the business unit"
  type        = string
}

variable "app" {
  description = "Name of the application, For ex: network, shared, ot etc."
  type        = string
}

variable "tenant" {
  description = "Name of the tenant"
  type        = string
  default     = ""
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