resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route = []

  tags = {
    Name = "public-rt-${var.env}-vpc"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route = []

  tags = {
    Name = "private-rt-${var.env}-vpc"
  }
}