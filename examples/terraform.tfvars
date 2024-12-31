env      = "d"
bu       = "ot"
app      = "bp"
tenant   = ""
vpc_id = "vpc-0f761216c07a6604c"
aws_security_group_variables = [
  {
    description = "common-desc-01"
    aws_security_group_egress = [ 
      {
        cidr_blocks = ["10.10.0.0/24"]
        description = "Allow SSH Connections"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"

      } 
    ]
    aws_security_group_ingress = [ 
      {
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow Connection Anywhere"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
      } 
    ]
  }
]