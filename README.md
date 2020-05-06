AWS Security Group Terraform module
=====================================

[![Opstree Solutions][opstree_avatar]][opstree_homepage]

[Opstree Solutions][opstree_homepage] 

  [opstree_homepage]: https://opstree.github.io/
  [opstree_avatar]: https://img.cloudposse.com/150x150/https://github.com/opstree.png

Terraform module which creates security group on AWS.

Types of resources supported:

* [Security Groups](https://www.terraform.io/docs/providers/aws/r/security_group.html)

Terraform versions
------------------

Terraform >=v0.12

Usage
------
```hcl
Note:
1. You will be able to create security group rule to allow an ip/cidr-range or 
   to allow other security group instead of ip/cidr-range. However you can allow both simultaneously.

      enable_whitelist_ip                     = true    
      enable_source_security_group_entry      = false
      create_outbound_rule_with_src_sg_id     = false
    
    1.1 When you want to whitelist ip/cidr-range and not source security group id, 
          enable_whitelist_ip = true
    1.2 When you want to allow source security group id and not whitelist ip/cidr, 
          enable_source_security_group_entry = true
    1.3 When you want to allow both source security group id and whitelist ip/cidr, 
          enable_whitelist_ip                     = true
          enable_source_security_group_entry      = true
    1.4 When you want to allow any security group for outbound rule
          create_outbound_rule_with_src_sg_id = true
```
```hcl
provider "aws" {
  region                  = "us-east-1"
}

module "security_group" {
    source = "path to your main.tf"
    enable_whitelist_ip                          = true
    enable_source_security_group_entry           = false
    create_outbound_rule_with_src_sg_id          = false

    name_sg                                 = "example"
    vpc_id                                  = "your-vpc-id-here" 

    tags = {Environment = "dev"}

    ingress_rule = {
        rules = {
            rule_list = [
                {
                    description = "Rule for port 80"
                    from_port = 80
                    to_port = 80
                    protocol = "tcp"
                    cidr = ["10.123.210.0/24", "18.45.43.21/32"]
                    source_SG_ID = ["source-security-group-id-here"]
                },
                { 
                    description = "Rule for port 443"
                    from_port = 443
                    to_port = 443
                    protocol = "tcp"
                    cidr = ["0.0.0.0/0"]
                    source_SG_ID = ["source-security-group-id-here"]
                }
            ]
        }
    }
    ## include egress_rule only when you want to override default(all allow) outbound rule ##
    #egress_rule = {
    #    rules = {
    #       rule_list = [
    #           {
    #               description = "Egress rule"
    #               from_port = 80
    #               to_port = 80
    #               protocol = "tcp"
    #               cidr = ["0.0.0.0/0"]
    #               source_SG_ID = "source-security-group-id-here"
    #           },
    #           {
    #               description = "Egress rule"
    #               from_port = 443
    #               to_port = 443
    #               protocol = "tcp"
    #               cidr = ["0.0.0.0/0"]
    #               source_SG_ID = "source-security-group-id-here"
    #           }
    #       ]
    #    }
    #}
}
```
Tags
----
* Tags are assigned to the resource.
* Additional tags can be assigned by appending key-value of tag in security group resource.

Inputs
------
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name_sg | Name of the security group | `string` | `" "` | yes |
| vpc_id | Id of your VPC  | `string` | `" "` | yes |
| tag_name_value | Value for the key Name to define tag | `string` | `" "` | yes |
| tag_env_value | Value for the key Environment to define tag | `string` | `" "` | yes |
| enable_whitelist_ip | Set this to true when you want to allow an Ip or cidr-range | `boolean` | `"true"` | no |
| enable_source_security_group_entry | Set this to true when you want to allow any other security group | `boolean` | `"false"` | no |
| create_outbound_rule_with_src_sg_id | Set this to true when you need to create outbound rule to allow security groups | `boolean` | `"false"` | no |
| ingress_rule | Define parameter's of inbound rules | `list(object)` | `" "` | no |
| egress_rule | Define parameter's of outbound rules | `list(object)` | `"Allow all"` | no |

Output
------
| Name | Description |
|------|-------------|
| sg_id | The ID of the Security group |
| sg_arn | The arn of the Security group |

### Contributors
Shatrujeet
