########## Web Security Group ####################
resource "aws_security_group" "web_sg" {
  name                             = format("%s-web_sg", var.name)
  description                      = "Web security group"
  vpc_id                           = aws_vpc.main.id
  tags = merge(
    {
    Name                           = format("%s-web_sg", var.name)
  },
    var.tags,
  )
}

resource "aws_security_group_rule" "sg_egress" {
  count                            = length(var.sg_egress_to_port)
  type                             = "egress"
  from_port                        = element(var.sg_egress_from_port,count.index)
  to_port                          = element(var.sg_egress_to_port,count.index)
  protocol                         = "tcp"
  cidr_blocks                      = ["0.0.0.0/0"]
  security_group_id                = aws_security_group.web_sg.id
}

resource "aws_security_group_rule" "sg_ingress" {
  count                            = length(var.sg_ingress_to_port)
  type                             = "ingress"
  from_port                        = element(var.sg_ingress_from_port,count.index)
  to_port                          = element(var.sg_ingress_to_port,count.index)
  protocol                         = "tcp"
  cidr_blocks                      = ["0.0.0.0/0"]
  security_group_id                = aws_security_group.web_sg.id
}

######################## open when you need ssh sg ########################################
# ########## SSh Security Group ####################
# resource "aws_security_group" "ssh_sg" {
#   name                             = format("%s-ssh_sg", var.name)
#   description                      = "SSH security group"
#   vpc_id                           = aws_vpc.main.id
#   ingress {
#     from_port                      = 22
#     to_port                        = 22
#     protocol                       = "tcp"
#     cidr_blocks                    = var.whitelist_ssh_ip
#   }
#   tags = merge(
#     {
#     Name                           = format("%s-ssh_sg", var.name)
#   },
#     var.tags,
#   )
# }
