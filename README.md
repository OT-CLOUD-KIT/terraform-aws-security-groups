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

    ingress_rule = [
                {
                description  = "opening port 80 for sg"
                from_port    = 80
                to_port      = 80
                protocol     = "tcp"
                source_SG_ID = "sg-0cdd1d74c594e7b79"
                },
                {
                description  = "opening port 443 for sg"
                from_port    = 443
                to_port      = 443
                protocol     = "tcp"
                source_SG_ID = "sg-0cdd1d74c594e7b79"
                },
                {
                description = "opening port 80 for everyone"
                from_port   = 80
                to_port     = 80
                protocol    = "tcp"
                cidr        = ["0.0.0.0/0"]
                },
                {
                description = "opening port 443 for everyone"
                from_port   = 443
                to_port     = 443
                protocol    = "tcp"
                cidr        = ["0.0.0.0/0"]
                }
            ]
    
    egress_rule =[
                {
                description = "Allow port 22 for specific CIDR blocks"
                from_port   = 22
                to_port     = 22
                protocol    = "tcp"
                cidr        = ["10.10.0.0/24", "10.10.0.0/16"]
                },
                {
                description  = "Allow port 22 for specific sg"
                from_port    = 22
                to_port      = 22
                protocol     = "tcp"
                source_SG_ID = "sg-0cdd1d74c594e7b79"
                }
           ]
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
| ingress_rule | Define parameter's of inbound rules | `list(object)` | `" "` | no |
| egress_rule | Define parameter's of outbound rules | `list(object)` | `"Allow all"` | no |

Output
------
| Name | Description |
|------|-------------|
| sg_id | The ID of the Security group |
| sg_arn | The arn of the Security group |

### Contributors
- Nikhil panchal
- Ashutosh Yadav
