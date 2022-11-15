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


resource "aws_security_group_rule" "ingress_rule_with_cidr" {
  count                    = var.enable_whitelist_ip == true ? length(local.ingress_cidr_rules.rule_list) : 0
  type                     = "ingress"
  description              = local.ingress_cidr_rules.rule_list[count.index].description
  from_port                = local.ingress_cidr_rules.rule_list[count.index].from_port
  to_port                  = local.ingress_cidr_rules.rule_list[count.index].to_port
  protocol                 = local.ingress_cidr_rules.rule_list[count.index].protocol
  cidr_blocks              = local.ingress_cidr_rules.rule_list[count.index].cidr
  ipv6_cidr_blocks         = local.ingress_cidr_rules.rule_list[count.index].ipv6_cidr
  security_group_id        = aws_security_group.security_group.id
}

resource "aws_security_group_rule" "egress_rule_with_cidr" {
  count                    = var.enable_whitelist_ip == true ? length(local.egress_cidr_rules.rule_list) : 0
  type                     = "egress"
  description              = local.egress_cidr_rules.rule_list[count.index].description
  from_port                = local.egress_cidr_rules.rule_list[count.index].from_port
  to_port                  = local.egress_cidr_rules.rule_list[count.index].to_port
  protocol                 = local.egress_cidr_rules.rule_list[count.index].protocol
  cidr_blocks              = local.egress_cidr_rules.rule_list[count.index].cidr
  ipv6_cidr_blocks         = local.egress_cidr_rules.rule_list[count.index].ipv6_cidr
  security_group_id        = aws_security_group.security_group.id
}

resource "aws_security_group_rule" "ingress_rule_with_sg_id" {
  count                    = var.enable_source_security_group_entry == true ? length(local.ingress_sg_id_rules.rule_list) : 0
  type                     = "ingress"
  description              = local.ingress_sg_id_rules.rule_list[count.index].description
  from_port                = local.ingress_sg_id_rules.rule_list[count.index].from_port
  to_port                  = local.ingress_sg_id_rules.rule_list[count.index].to_port
  protocol                 = local.ingress_sg_id_rules.rule_list[count.index].protocol
  source_security_group_id = local.ingress_sg_id_rules.rule_list[count.index].source_SG_ID
  security_group_id        = aws_security_group.security_group.id
}

resource "aws_security_group_rule" "egress_rule_with_sg_id" {
  count                    = var.enable_source_security_group_entry == true ? length(local.egress_sg_id_rules.rule_list) : 0
  type                     = "egress"
  description              = local.egress_sg_id_rules.rule_list[count.index].description
  from_port                = local.egress_sg_id_rules.rule_list[count.index].from_port
  to_port                  = local.egress_sg_id_rules.rule_list[count.index].to_port
  protocol                 = local.egress_sg_id_rules.rule_list[count.index].protocol
  source_security_group_id = local.egress_sg_id_rules.rule_list[count.index].source_SG_ID
  security_group_id        = aws_security_group.security_group.id
}


