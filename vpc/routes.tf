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

resource "aws_route" "public-peer-add" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = var.default_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  //depends_on                = [aws_route_table.testing]
}

resource "aws_route" "private-peer-add" {
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = var.default_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  //depends_on                = [aws_route_table.testing]
}

resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public.*.id)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private.*.id)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.id
}

#resource "aws_route" "default-vpc-route-table" {
#  route_table_id            = data.aws_vpc.default.main_route_table_id
#  destination_cidr_block    = var.default_vpc_cidr
#  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
#  //depends_on                = [aws_route_table.testing]
#}

output "all" {
  value = local.all_cidr_vpc
}