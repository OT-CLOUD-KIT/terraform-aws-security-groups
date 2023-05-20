locals {
  sg_ingress_rules = flatten([for rules in var.ingress_rule :
    merge({
      rules_map = rules,
      key       = join(" ", ["cidr_block"], rules.cidr, ["from_port"], [rules.from_port], ["to_port"], [rules.to_port], ["ipv6_cidr"], rules.ipv6_cidr, ["source_sg_id"], [rules.source_SG_ID], ["protocol"], [rules.protocol])
    })
  ])


  security_group_ingress_rules = { for rules in local.sg_ingress_rules :
    rules.key => rules.rules_map
  }

  sg_egress_rules = flatten([for rules in var.egress_rule :
    merge({
      rules_map = rules,
      key       = join(" ", ["cidr_block"], rules.cidr, ["from_port"], [rules.from_port], ["to_port"], [rules.to_port], ["ipv6_cidr"], rules.ipv6_cidr, ["source_sg_id"], [rules.source_SG_ID], ["protocol"], [rules.protocol])
    })
  ])

  security_group_egress_rules = { for rules in local.sg_egress_rules :
    rules.key => rules.rules_map
  }
}
