resource "aws_instance" "on-demand" {
  count = var.od_count
  ami = data.aws_ami.ami.id
  instance_type = var.instance_type
  subnet_id = element(data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS, count.index )
  vpc_security_group_ids = [aws_security_group.allow_app_component.id]
  tags = {
    Name = "${var.component}-${var.env}"
  }
}

resource "aws_spot_instance_request" "spot" {
  count = var.spot_count
  ami           = data.aws_ami.ami.id
  instance_type = var.instance_type
  subnet_id = element(data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS, count.index )
  vpc_security_group_ids = [aws_security_group.allow_app_component.id]
  wait_for_fulfillment = true

  tags = {
    Name = "${var.component}-${var.env}"
  }
}

resource "aws_ec2_tag" "spot-ec2-tag" {
  count = length(var.spot_count)
  resource_id = element(aws_spot_instance_request.spot.*.spot_instance_id, count.index)
  key         = "Name"
  value       = "${var.component}-${var.env}"
}

resource "aws_security_group" "allow_app_component" {
  name        = "allow_${var.component}_${var.env}"
  description = "Allow ${var.component}"
  vpc_id = data.terraform_remote_state.vpc.outputs.VPC_ID

  ingress = [{
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = local.all_cidr_vpc
    ipv6_cidr_blocks = []
    self             = false
    prefix_list_ids  = []
    security_groups  = []
  },
    {
      description      = "APP"
      from_port        = 8080
      to_port          = 8080
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
    Name = "allow_${var.component}_${var.env}"
  }
}