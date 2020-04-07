variable "name_sg" {
    description                     = "Name of the Scurity group"
    default                         = ""
}
variable "vpc_id" {
    description                     = "The VPC id"
    default                         = ""
}
################## specify your requirement ############################
variable "enable_whitelisting_ip" {
  description = "Do you want to whitelist your Ip/cidr-range"
  type = bool
  #default = ""
}
variable "enable_source_security_group_entry" {
  description = "Do you want to use source security group instead of Ip/cidr-range"
  type = bool
  #default = ""
}
variable "create_outbound_rule" {
  description = "Do you want to create outbound rules"
  type = bool
  #default = ""
}

####################### ingress variables ##############################
variable "ingress_from_port" {
    description = "The start port, From traffic is comming"
    type = list(number)
    default = []
}
variable "ingress_to_port" {
    description = "The end rage port"
    type = list(number)
    default = []
}
variable "ingress_protocol" {
    description = "protocol"
    type = string
    default = ""
}
variable "ingress_cidr" {
    description = "cidr block to allow"
    type = list(string)
    default = []
}
variable "src_sg_id" {
    description = "Source security group"
    type = string
    default = ""
}

######################## egress variables ################################
variable "egress_from_port" {
    description = "The start port, From traffic is comming"
    type = list(number)
    default = [0]
}
variable "egress_to_port" {
    description = "The end rage port"
    type = list(number)
    default = [0]
}
variable "egress_protocol" {
    description = "protocol_ssh"
    type = string
    default = "-1"
}

variable "egress_cidr" {
    description = "cidr block to allow"
    type = list(string)
    default = ["0.0.0.0/0"]
}

########################### TAGS ############################
variable "tag_name_value" {
    description = "The value of tag Name"
    default = ""
}

variable "tag_env_value" {
    description = "The value of tag Name"
    default = ""
}
