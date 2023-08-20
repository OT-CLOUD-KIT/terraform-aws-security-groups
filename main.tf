resource "aws_security_group" "security_group" {
  count  = var.security_group_id == null ? 1 : 0
  name   = var.name_sg
  vpc_id = var.vpc_id
  tags = merge(
    {
      "Name" = var.name_sg
    },
    var.tags,
  )
}

resource "aws_security_group_rule" "ingress_rule" {
  type                     = "ingress"
  for_each                 = var.ingress_rules != null ? var.ingress_rules : {}
  description              = each.value.description != null ? each.value.description : each.key
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  cidr_blocks              = each.value.source_SG_ID == null ? each.value.cidr : null
  source_security_group_id = each.value.source_SG_ID != null ? each.value.source_SG_ID : null
  ipv6_cidr_blocks         = each.value.source_SG_ID == null ? each.value.ipv6_cidr : null
  security_group_id        = var.security_group_id == null ? aws_security_group.security_group[0].id : var.security_group_id
}

resource "aws_security_group_rule" "egress_rule" {
  type                     = "egress"
  for_each                 = var.security_group_id == null && var.add_default_egress_rule ? var.default_egress_rule : var.egress_rules
  description              = each.value.description != null ? each.value.description : each.key
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  cidr_blocks              = each.value.source_SG_ID == null ? each.value.cidr : null
  source_security_group_id = each.value.source_SG_ID != null ? each.value.source_SG_ID : null
  ipv6_cidr_blocks         = each.value.source_SG_ID == null ? each.value.ipv6_cidr : null
  security_group_id        = var.security_group_id == null ? aws_security_group.security_group[0].id : var.security_group_id
}
