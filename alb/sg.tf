resource "aws_security_group" "internal-lb" {
  name        = "internal_lb_${var.env}"
  description = "internal-lb"
  vpc_id = data.terraform_remote_state.vpc.outputs.VPC_ID

  ingress = [
    {
      description      = "HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = data.terraform_remote_state.vpc.outputs.VPC_CIDR
      ipv6_cidr_blocks = []
      self             = false
      prefix_list_ids  = []
      security_groups  = []
    }

  ]
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
  }

  tags = {
    Name = "internal_lb_${var.env}"
  }
}

resource "aws_security_group" "public_lb" {
  name        = "public_lb_${var.env}"
  description = "public_lb"
  vpc_id = data.terraform_remote_state.vpc.outputs.VPC_ID

  ingress = [
    {
      description      = "HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = "0.0.0.0/0"
      ipv6_cidr_blocks = []
      self             = false
      prefix_list_ids  = []
      security_groups  = []
    }

  ]
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
  }

  tags = {
    Name = "allow_mongodb_${var.env}"
  }
}