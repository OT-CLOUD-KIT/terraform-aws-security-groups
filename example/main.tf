provider "aws" {
  region                  = "us-east-1"
}

module "security_group" {
  source       = "path to module"
  name_sg      = "example"
  vpc_id       = "vpc-1234567890"
  ingress_rule = var.sg_ingress_rules
  egress_rule  = var.egress_rule
}