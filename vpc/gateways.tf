resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.env}-igw"
  }
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.ngw.id
  subnet_id     = aws_subnet.public.*.id[0]

  tags = {
    Name = "${var.env}-natgw"
  }

  depends_on = [aws_internet_gateway.gw]
}

resource "aws_eip" "ngw" {
  vpc      = true
}