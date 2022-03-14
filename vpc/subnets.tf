resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = element(var.public_subnet_cidr, count.index)

  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}