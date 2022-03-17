resource "aws_spot_instance_request" "mongodb" {
  ami           = data.aws_ami.ami.id
  instance_type = var.mongodb_instance_type
  subnet_id = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS[0]
  vpc_security_group_ids = [aws_security_group.allow_mongodb.id]

  tags = {
    Name = "mongodb-${var.env}"
  }
}

resource "aws_ec2_tag" "mongodb" {
  resource_id = aws_spot_instance_request.mongodb.spot_instance_id
  key         = "Name"
  value       = "mongodb-${var.env}"
}

resource "aws_security_group" "allow_mongodb" {
  name        = "allow_mongodb_${var.env}"
  description = "Allow Mongodb"

  ingress = [{
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = local.all_cidr_vpc
    ipv6_cidr_blocks = []
  },
  {
    description      = "MONGODB"
    from_port        = 27017
    to_port          = 27017
    protocol         = "tcp"
    cidr_blocks      = data.terraform_remote_state.vpc.outputs.VPC_CIDR
    ipv6_cidr_blocks = []
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