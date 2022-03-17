resource "aws_spot_instance_request" "cheap_worker" {
  ami           = data.aws_ami.ami
  instance_type = var.mongodb_instance_type

  tags = {
    Name = "mongodb-${var.env}"
  }
}