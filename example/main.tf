provider "aws" {
  region = "ap-south-1"
}
## For creating new security group 
module "security_group" {
  source  = "../"
  name_sg = "sg"
  vpc_id  = "vpc-1234567890"
  ingress_rules = {
    "Open port 22 for everyone" = {
      from_port = 22
      to_port   = 22
      protocol  = "tcp"
      cidr      = ["0.0.0.0/0"]
    }
  }

}

## For adding security group rule to existing security group
module "add_sg_rule" {
  source            = "../"
  security_group_id = "sg-01234567890"
  ingress_rules = {
    "Open port 22 for everyone" = {
      from_port = 22
      to_port   = 22
      protocol  = "tcp"
      cidr      = ["0.0.0.0/0"]
    }
  }
  egress_rules = {
    "Open port 22 for everyone" = {
      from_port = 22
      to_port   = 22
      protocol  = "tcp"
      cidr      = ["0.0.0.0/0"]
    }
  }
}