resource "aws_vpc_peering_connection" "peer" {
  peer_owner_id = "286176496219"
  peer_vpc_id   = aws_vpc.main.id
  vpc_id        = "vpc-0bad3c576d4bb924d"
}