resource "aws_lb" "internal" {
  name               = "backend-${var.env}"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.internal-lb.id]
  subnets            = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS

  tags = {
    Environment = "backend-${var.env}"
  }
}

resource "aws_lb" "public" {
  name               = "public-${var.env}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public_lb.id]
  subnets            = data.terraform_remote_state.vpc.outputs.PUBLIC_SUBNET_IDS

  tags = {
    Environment = "internal-${var.env}"
  }
}

