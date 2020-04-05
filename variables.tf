
variable "sg_egress_from_port" {
  description = "The from port to match egress rule in security group"
  type = list(number)
  default = [80,443]
}

variable "sg_egress_to_port" {
   description = "The to port to match egress rule in security group"
  type = list(number)
  default = [80,443]
}

variable "sg_ingress_from_port" {
   description = "The from port to match ingress rule in security group"
  type = list(number)
  default = [80,443]
}

variable "sg_ingress_to_port" {
  description = "The to port to match ingress rule in security group"
  type = list(number)
  default = [80,443]
}

variable "whitelist_ssh_ip" {
  description = "The ip address allowed to do ssh"
  type = list(string)
  default = ["0.0.0.0/0"]
}

