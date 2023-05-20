resource "aws_security_group" "security_group" {
  name   = var.name_sg
  vpc_id = var.vpc_id
  tags = merge(
    {
      "Name" = var.name_sg
    },
    {
      "provisioner" = var.provisioner
    },
    var.tags,
  )
}

resource "aws_security_group_rule" "ingress_rule" {
  type                     = "ingress"
  for_each                 = local.security_group_ingress_rules
  description              = each.value.description
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  cidr_blocks              = each.value.source_SG_ID == "" ? each.value.cidr : null
  source_security_group_id = each.value.source_SG_ID != "" ? each.value.source_SG_ID : null
  ipv6_cidr_blocks         = each.value.source_SG_ID == "" ? each.value.ipv6_cidr : null
  security_group_id        = aws_security_group.security_group.id
}

resource "aws_security_group_rule" "egress_rule" {
  type                     = "egress"
  for_each                 = local.security_group_egress_rules
  description              = each.value.description
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  cidr_blocks              = each.value.source_SG_ID == "" ? each.value.cidr : null
  source_security_group_id = each.value.source_SG_ID != "" ? each.value.source_SG_ID : null
  ipv6_cidr_blocks         = each.value.source_SG_ID == "" ? each.value.ipv6_cidr : null
  security_group_id        = aws_security_group.security_group.id
}