################## simple security group #####################
module "security_group" {
  source                                  = "../modules/securityGroup"

  enable_whitelisting_ip                  = false
  enable_source_security_group_entry      = false
  create_outbound_rule                    = false

  name_sg                                 = "temp-g"
  vpc_id                                  = "vpc-99b288e3" 

  ingress_from_port                       = [80,443]
  ingress_to_port                         = [80,443] 
  ingress_protocol                        = "tcp"
  ingress_cidr                            = ["0.0.0.0/0"]

  src_sg_id                               = "sg-1b1a4737"

  egress_from_port                        = [0] 
  egress_to_port                          = [0]
  egress_protocol                         = "-1" 
  egress_cidr                             = ["0.0.0.0/0"]

  tag_name_value                          = "temp"
  tag_env_value                           = "QA"
}