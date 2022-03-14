resource "aws_vpc_peering_connection" "peer" {
  peer_owner_id = "2861-7649-6219"
  peer_vpc_id   = aws_vpc.main.id
  vpc_id        = "vpc-0c4120c3db369ac9f"
}