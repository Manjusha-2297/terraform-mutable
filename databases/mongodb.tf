resource "aws_spot_instance_request" "cheap_worker" {
  ami           = data.aws_ami.ami
  instance_type = var.mongodb_instance_type
  subnet_id = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNETS_CIDR[0]

  tags = {
    Name = "mongodb-${var.env}"
  }
}