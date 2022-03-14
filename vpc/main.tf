resource "aws_vpc" "main" {
  cidr_block = var.public_vpc_cidr
  tags = {
    Name = var.env
  }
}