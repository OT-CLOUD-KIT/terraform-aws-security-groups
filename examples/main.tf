
module "standard_tags" {
  source = "git@github.com:OT-CLOUD-KIT/terraform-aws-standard-tagging.git?ref=dev"
  env     = var.env
  app     = var.app
  bu      = var.bu
  program = "edcil" 
  team    = "lspl"
  region  = "ap-south-1"
}

module "name_sg" {
  source   = "git@github.com:OT-CLOUD-KIT/terraform-aws-naming.git?ref=dev"
  bu       = var.bu
  env      = var.env
  app      = var.app
  tenant   = var.tenant
   resource = "sg"
}

module "sg_example" {
  source                       = "../"
  vpc_id                       = var.vpc_id
  tags                         = module.standard_tags.standard_tags
  name                         = module.name_sg.naming_tag[0]
  aws_security_group_variables = var.aws_security_group_variables
}