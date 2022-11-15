
locals{
ingress_rule_with_cidr = toset([for each in var.ingress_rule : each if each.source_SG_ID == ""])

ingress_cidr_rules = {
    rule_list = flatten(local.ingress_rule_with_cidr)
}

ingress_rule_with_sg_id = toset([for each in var.ingress_rule : each if each.source_SG_ID != "" ])

ingress_sg_id_rules = {
    rule_list = flatten(local.ingress_rule_with_sg_id)
}

egress_rule_with_cidr = toset([for each in var.egress_rule : each if each.source_SG_ID == ""])

egress_cidr_rules = {
    rule_list = flatten(local.egress_rule_with_cidr)
}

egress_rule_with_sg_id = toset([for each in var.egress_rule : each if each.source_SG_ID != "" ])

egress_sg_id_rules = {
    rule_list = flatten(local.egress_rule_with_sg_id)
}

}