variable "name_sg" {
  description = "Name of the Scurity group"
  type        = string
  default     = "security-group"
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = null
}

variable "vpc_id" {
  description = "The VPC id in which security group is going to create"
  type        = string
  default     = null
}

variable "security_group_id" {
  type        = string
  default     = null
  description = "Security group id for adding rules"
}

variable "ingress_rules" {
  type = map(object({
    description  = optional(string)
    from_port    = number
    to_port      = number
    protocol     = string
    cidr         = optional(list(string), null)
    ipv6_cidr    = optional(list(string), null)
    source_SG_ID = optional(string, null)
  }))
  default     = null
  description = "List of ingress rules for security group"
}

variable "add_default_egress_rule" {
  type        = bool
  default     = true
  description = "Whether to add default egress rule to new security group"
}

variable "default_egress_rule" {
  type = map(object({
    description  = optional(string)
    from_port    = number
    to_port      = number
    protocol     = string
    cidr         = optional(list(string), null)
    ipv6_cidr    = optional(list(string), null)
    source_SG_ID = optional(string, null)
  }))

  default = {
    "Default egress rule" = {
      from_port = 0
      to_port   = 0
      protocol  = "-1"
      cidr      = ["0.0.0.0/0"]
    }
  }
  description = "List of egress rules for security group"
}

variable "egress_rules" {
  type = map(object({
    description  = optional(string)
    from_port    = number
    to_port      = number
    protocol     = string
    cidr         = optional(list(string), null)
    ipv6_cidr    = optional(list(string), null)
    source_SG_ID = optional(string, null)
  }))

  default     = {}
  description = "List of egress rules for security group"
}