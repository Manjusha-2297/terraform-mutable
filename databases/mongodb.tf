resource "aws_spot_instance_request" "cheap_worker" {
  ami           = data.aws_ami.ami.id
  instance_type = var.mongodb_instance_type
  subnet_id = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNETS_IDS[0]

  tags = {
    Name = "mongodb-${var.env}"
  }
}