resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.default_vpc_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  }

  route {
    ipv6_cidr_block        = var.default_vpc_cidr
    egress_only_gateway_id = aws_vpc_peering_connection.peer.id
  }

  tags = {
    Name = "public-rt-${var.env}-vpc"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.default_vpc_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  }

  route {
    ipv6_cidr_block        = var.default_vpc_cidr
    egress_only_gateway_id = aws_vpc_peering_connection.peer.id
  }

  tags = {
    Name = "public-rt-${var.env}-vpc"
  }
}