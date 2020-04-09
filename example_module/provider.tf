################### Terraform settings ####################
terraform {
  required_version = ">= v0.12.0"
}

################### Provider settings #####################
provider "aws" {
  region = "us-east-1"
}
