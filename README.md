/******************* Security Group with cidr/security_group_id *******************/
1. You must specify whether you want to create security group rule to whitelist ip/cidr or
   you want to give source security group instead of ip/cidr.
    e.g
      enable_whitelisting_ip                  = false    
      enable_source_security_group_entry      = false   ### when you want to give security group
      create_outbound_rule                    = false
    
    1.1 When you want to whitelist ip/cidr and not source security group id, 
        set "enable_whitelisting_ip" to true.
    1.2 When you want to specify source security group id and not whitelist ip/cidr, 
        set "enable_source_security_group_entry" to true.
    1.3 When you want to configure outbound rule by yourself instead of usinf default,
        set "create_outbound_rule" to true


2. You can create your security group module like below
    module "security_group" {
        source                                  = "./modules/securityGroup"

        enable_whitelisting_ip                  = false
        enable_source_security_group_entry      = false
        create_outbound_rule                    = false

        name_sg                                 = "temp-g"
        vpc_id                                  = "vpc-99b288e3" 
        
        #### set ingress rule for ip/cidr whitelist or use of source_security_group_id
        ingress_from_port                       = [80,443]
        ingress_to_port                         = [80,443] 
        ingress_protocol                        = "tcp"
        ingress_cidr                            = ["0.0.0.0/0"]

        #### when you have enable_source_security_group_entry set to true then
        #### you need to specify the source security group id
        src_sg_id                               = "sg-1b1a4737"

        #### configure outbound rule when you don't want deafault one 
        egress_from_port                        = [0] 
        egress_to_port                          = [0]
        egress_protocol                         = "-1" 
        egress_cidr                             = ["0.0.0.0/0"]

        tag_name_value                          = "temp"
        tag_env_value                           = "QA"
    }