resource "aws_security_group" "security_group" {
    name =  var.name_sg
    vpc_id = var.vpc_id 
    tags = merge(
        {
            "Name"                       = var.name_sg
        },
        {
            "Provisioner"                = var.provisioner
        },
        var.tags,
    )
}

resource "aws_security_group_rule" "with_cidr_blocks" {
    count                            = var.enable_whitelist_ip ? length(var.ingress_rule.rules.rule_list) : 0
    type                             = var.type_ingress_rule
    description                      = var.ingress_rule.rules.rule_list[count.index].description
    from_port                        = var.ingress_rule.rules.rule_list[count.index].from_port
    to_port                          = var.ingress_rule.rules.rule_list[count.index].to_port
    protocol                         = var.ingress_rule.rules.rule_list[count.index].protocol
    cidr_blocks                      = var.ingress_rule.rules.rule_list[count.index].cidr
    security_group_id                = aws_security_group.security_group.id
}

locals {
    rules = var.ingress_rule.rules
    rule_list1 = [
        for ruleList in local.rules.rule_list:
        {
            description = ruleList.description
            from_port = ruleList.from_port
            to_port = ruleList.to_port
            protocol = ruleList.protocol
            cidr = ruleList.cidr
            source_SG_ID = ruleList.source_SG_ID[0]
        }
    ]
    rule_list2 = [
        for ruleList in local.rules.rule_list:
        {
            description = ruleList.description
            from_port = ruleList.from_port
            to_port = ruleList.to_port
            protocol = ruleList.protocol
            cidr = ruleList.cidr
            source_SG_ID = ruleList.source_SG_ID[1]
        } if length(ruleList.source_SG_ID) > 1
    ]
    rule_list3 = [
        for ruleList in local.rules.rule_list:
        {
            description = ruleList.description
            from_port = ruleList.from_port
            to_port = ruleList.to_port
            protocol = ruleList.protocol
            cidr = ruleList.cidr
            source_SG_ID = ruleList.source_SG_ID[2]
        } if length(ruleList.source_SG_ID) > 2
    ]
    rule_list4 = [
        for ruleList in local.rules.rule_list:
        {
            description = ruleList.description
            from_port = ruleList.from_port
            to_port = ruleList.to_port
            protocol = ruleList.protocol
            cidr = ruleList.cidr
            source_SG_ID = ruleList.source_SG_ID[3]
        } if length(ruleList.source_SG_ID) > 3
    ]
    rule_list5 = [
        for ruleList in local.rules.rule_list:
        {
            description = ruleList.description
            from_port = ruleList.from_port
            to_port = ruleList.to_port
            protocol = ruleList.protocol
            cidr = ruleList.cidr
            source_SG_ID = ruleList.source_SG_ID[4]
        } if length(ruleList.source_SG_ID) > 4
    ]
    newRules = {
        rule_list = concat(local.rule_list1, local.rule_list2, local.rule_list3, local.rule_list4, local.rule_list5)
    }
}

resource "aws_security_group_rule" "with_source_sg" {
    count                            = var.enable_source_security_group_entry ? length(local.newRules.rule_list) : 0
    type                             = var.type_ingress_rule
    description                      = local.newRules.rule_list[count.index].description
    from_port                        = local.newRules.rule_list[count.index].from_port
    to_port                          = local.newRules.rule_list[count.index].to_port
    protocol                         = local.newRules.rule_list[count.index].protocol
    source_security_group_id         = local.newRules.rule_list[count.index].source_SG_ID
    security_group_id                = aws_security_group.security_group.id
}

resource "aws_security_group_rule" "sg_egress_with_cidr" {
    count                            = length(var.egress_rule.rules.rule_list)
    type                             = var.type_egress_rule
    description                      = var.egress_rule.rules.rule_list[count.index].description
    from_port                        = var.egress_rule.rules.rule_list[count.index].from_port
    to_port                          = var.egress_rule.rules.rule_list[count.index].to_port
    protocol                         = var.egress_rule.rules.rule_list[count.index].protocol
    cidr_blocks                      = var.egress_rule.rules.rule_list[count.index].cidr
    security_group_id                = aws_security_group.security_group.id
}

resource "aws_security_group_rule" "sg_egress_with_src_sg_id" {
    count                            = var.create_outbound_rule_with_src_sg_id ? length(var.egress_rule.rules.rule_list) : 0
    type                             = var.type_egress_rule
    description                      = var.egress_rule.rules.rule_list[count.index].description
    from_port                        = var.egress_rule.rules.rule_list[count.index].from_port
    to_port                          = var.egress_rule.rules.rule_list[count.index].to_port
    protocol                         = var.egress_rule.rules.rule_list[count.index].protocol
    source_security_group_id         = var.egress_rule.rules.rule_list[count.index].source_SG_ID
    security_group_id                = aws_security_group.security_group.id
}

