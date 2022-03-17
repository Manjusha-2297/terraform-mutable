resource "aws_spot_instance_request" "mongodb" {
  ami           = data.aws_ami.ami.id
  instance_type = var.mongodb_instance_type
  subnet_id = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS[0]

  tags = {
    Name = "mongodb-${var.env}"
  }
}

resource "aws_ec2_tag" "mongodb" {
  key         = "Name"
  resource_id = aws_spot_instance_request.mongodb.spot_instance_id
  value       = "mongodb-${var.env}"
}
