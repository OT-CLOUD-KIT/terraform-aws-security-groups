module "security_group" {
  source = "../"
  enable_whitelist_ip                       = true
  enable_source_security_group_entry           = false
  create_outbound_rule_with_src_sg_id          = false
  name_sg = "temp-group"
  vpc_id  = "vpc-99b288e3"
  tag_name_value = "temp"
  tag_env_value  = "QA"
  ingress_rule = {
    rules = {
      rule_list = [
          {
              from_port = 80
              to_port = 80
              protocol = "tcp"
              cidr = ["10.123.210.0/24", "18.45.43.21/32"]
              source_SG_ID = "sg-1b1a4737"
          },
          { 
              from_port = 443
              to_port = 443
              protocol = "tcp"
              cidr = ["0.0.0.0/0"]
              source_SG_ID = "sg-1b1a4737"
          }
      ]
    }
  }
  egress_rule = {
    rules = {
      rule_list = [
        {
          from_port = 0
          to_port = 0
          protocol = "-1"
          cidr = ["0.0.0.0/0"]
          source_SG_ID = "sg-1b1a4737"
        }
      ]
    }
  }
}