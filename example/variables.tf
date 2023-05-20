variable "egress_rule" {
  type = list(object({
    description  = string
    from_port    = number
    to_port      = number
    protocol     = string
    cidr         = optional(list(string))
    ipv6_cidr    = optional(list(string))
    source_SG_ID = optional(string)
  }))
  default = [
    {
      description = "Allow port 22 for specific CIDR block"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr        = ["10.10.0.0/24", "10.10.0.0/16"]
    },
    {
      description  = "Allow port 22 for specific sg"
      from_port    = 22
      to_port      = 22
      protocol     = "tcp"
      source_SG_ID = "sg-0cdd1d74c594e7b79"
    }
  ]
}

variable "sg_ingress_rules" {
  type = list(object({
    description  = string
    from_port    = number
    to_port      = number
    protocol     = string
    cidr         = optional(list(string))
    ipv6_cidr    = optional(list(string))
    source_SG_ID = optional(string)
  }))
  default = [
    {
      description  = "opening port 80 for sg"
      from_port    = 80
      to_port      = 80
      protocol     = "tcp"
      source_SG_ID = "sg-0cdd1d74c594e7b79"
    },
    {
      description  = "opening port 443 for sg"
      from_port    = 443
      to_port      = 443
      protocol     = "tcp"
      source_SG_ID = "sg-0cdd1d74c594e7b79"
    },
    {
      description = "opening port 80 for everyone"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr        = ["0.0.0.0/0"]
    },
    {
      description = "opening port 443 for everyone"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr        = ["0.0.0.0/0"]
    }
  ]
}