resource "aws_security_group" "security_group" {
    name =  var.name_sg
    vpc_id = var.vpc_id 
    tags  = {
        Name =  var.tag_name_value,
        Environment = var.tag_env_value
    }
}
resource "aws_security_group_rule" "with_cidr_blocks" {
    count                            = var.enable_whitelisting_ip ? length(var.ingress_to_port) : 0
    type                             = "ingress"
    from_port                        = element(var.ingress_from_port,count.index)
    to_port                          = element(var.ingress_to_port,count.index)
    protocol                         = var.ingress_protocol
    cidr_blocks                      = var.ingress_cidr
    security_group_id                = aws_security_group.security_group.id
}

resource "aws_security_group_rule" "with_source_sg" {
    count                            = var.enable_source_security_group_entry ? length(var.ingress_to_port) : 0
    type                             = "ingress"
    from_port                        = element(var.ingress_from_port,count.index)
    to_port                          = element(var.ingress_to_port,count.index)
    protocol                         = var.ingress_protocol
    source_security_group_id         = var.src_sg_id
    security_group_id                = aws_security_group.security_group.id
}

resource "aws_security_group_rule" "sg_egress" {
    count                            = var.create_outbound_rule ? length(var.egress_to_port) : 0
    type                             = "egress"
    from_port                        = element(var.egress_from_port,count.index)
    to_port                          = element(var.egress_to_port,count.index)
    protocol                         = var.egress_protocol
    cidr_blocks                      = var.egress_cidr
    security_group_id                = aws_security_group.security_group.id
}
####################################################################################################
