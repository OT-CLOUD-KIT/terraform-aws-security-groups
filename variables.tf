variable "name_sg" {
  description = "Name of the Scurity group"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}

variable "provisioner" {
  description = "Provisioner for this resource"
  type        = string
  default     = "terraform"
}

variable "vpc_id" {
  description = "The VPC id"
  type        = string
  default     = ""
}

variable "ingress_rule" {
  type = list(object({
    description  = string
    from_port    = number
    to_port      = number
    protocol     = string
    cidr         = optional(list(string), [])
    ipv6_cidr    = optional(list(string), [])
    source_SG_ID = optional(string, "")
  }))
  default = [
    {
      description  = ""
      from_port    = 80
      to_port      = 80
      protocol     = ""
    },
    {
      description  = ""
      from_port    = 443
      to_port      = 443
      protocol     = ""
    }
  ]
}
variable "egress_rule" {
  type = list(object({
    description  = string
    from_port    = number
    to_port      = number
    protocol     = string
    cidr         = optional(list(string), [])
    ipv6_cidr    = optional(list(string), [])
    source_SG_ID = optional(string, "")
  }))
  default = [
    {
      description  = "Allow all outbound traffic"
      from_port    = 0
      to_port      = 0
      protocol     = "-1"
      cidr         = ["0.0.0.0/0"]
    }
  ]
}