resource "aws_db_subnet_group" "default" {
  name       = "mysql-dbsg-${var.env}"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS

  tags = {
    Name = "mysql-dbsg-${var.env}"
  }
}

resource "aws_db_security_group" "mysql" {
  count = length(local.all_cidr_vpc)
  name = "mysql-sg-${var.env}-${count.index+1}"

  ingress {
    cidr = element(local.all_cidr_vpc, count.index )
  }
}