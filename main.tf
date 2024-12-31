############################## Security Group(s) ##############################
resource "aws_security_group" "sg" {
  count       = length(var.aws_security_group_variables)
  name        = var.name
  description = var.aws_security_group_variables[count.index].description
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.aws_security_group_variables[count.index].aws_security_group_ingress != null ? var.aws_security_group_variables[count.index].aws_security_group_ingress : []

    content {
      description       = ingress.value["description"]
      from_port         = ingress.value["from_port"]
      to_port           = ingress.value["to_port"]
      protocol          = ingress.value["protocol"]
      cidr_blocks       = ingress.value["cidr_blocks"]
      security_groups   = ingress.value["security_groups"]
      ipv6_cidr_blocks  = ingress.value["ipv6_cidr_blocks"]
      prefix_list_ids   = ingress.value["prefix_list_ids"]
      self              = ingress.value["self"]
    }
  }

  dynamic "egress" {
    for_each = var.aws_security_group_variables[count.index].aws_security_group_egress != null ? var.aws_security_group_variables[count.index].aws_security_group_egress : []

    content {
      description       = egress.value["description"]
      from_port         = egress.value["from_port"]
      to_port           = egress.value["to_port"]
      protocol          = egress.value["protocol"]
      cidr_blocks       = egress.value["cidr_blocks"]
      security_groups   = egress.value["security_groups"]
      ipv6_cidr_blocks  = egress.value["ipv6_cidr_blocks"]
      prefix_list_ids   = egress.value["prefix_list_ids"]
      self              = egress.value["self"]
    }
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [vpc_id]
  }
}