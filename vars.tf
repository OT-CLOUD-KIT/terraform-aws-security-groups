variable "name_sg" {
    description                     = "Name of the Scurity group"
    type                            = string
    default                         = ""
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}

variable "provisioner" {
    description                     = "Provisioner for this resource"
    type                            = string
    default                         = "Terraform"
}

variable "vpc_id" {
    description                     = "The VPC id"
    type                            = string
    default                         = ""
}

variable "type_ingress_rule" {
  description = "To select the rule as ingress"
  type = string
  default = "ingress"
}

variable "type_egress_rule" {
  description = "To select the rule as egress"
  type = string
  default = "egress"
}

variable "enable_whitelist_ip" {
  description = "Do you want to whitelist your Ip/cidr-range"
  type = bool
  default = true
}

variable "enable_source_security_group_entry" {
  description = "Do you want to use source security group instead of Ip/cidr-range"
  type = bool
  default = false
}

variable "create_outbound_rule_with_src_sg_id" {
    description = "Do you want to create outbound rules"
    type = bool
    default = false
}

variable "ingress_rule" {
    type = object({
        rules = object({
            rule_list = list(object({
                description = string
                from_port = number
                to_port = number
                protocol = string
                cidr = list(string)
                source_SG_ID = list(string)
            }))
        })
    })
    default = {
        rules = {
            rule_list = [
                {
                    description = ""
                    from_port = 80
                    to_port = 80
                    protocol = ""
                    cidr = []
                    source_SG_ID = []
                },
                { 
                    description = ""
                    from_port = 443
                    to_port = 443
                    protocol = ""
                    cidr = []
                    source_SG_ID = []
                }
            ]
        }
    }
}
variable "egress_rule" {
    type = object({
        rules = object({
            rule_list = list(object({
                description = string
                from_port = number
                to_port = number
                protocol = string
                cidr = list(string)
                source_SG_ID = string
            }))
        })
    })
    default = {
        rules = {
            rule_list = [
                {
                    description = "Allow all outbound traffic"
                    from_port = 0
                    to_port = 0
                    protocol = "-1"
                    cidr = ["0.0.0.0/0"]
                    source_SG_ID = ""
                }
            ]
        }
    }
}
