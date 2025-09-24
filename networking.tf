resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  region     = "us-east-1"
  tags = {
    vpc_type = "root_vpc"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_security_group" "sg" {
  name        = "root_sg"
  vpc_id      = aws_vpc.main.id
  description = "main sg in the root account"
}

resource "aws_vpc_peering_connection" "dev_peer" {
  peer_owner_id = var.dev_account_id
  peer_vpc_id   = var.peer_vpc_id_dev
  peer_region   = "us-east-1"
  auto_accept   = true
  vpc_id        = aws_vpc.main.id
}

resource "aws_vpc_peering_connection" "uat_peer" {
  peer_owner_id = var.uat_account_id
  peer_vpc_id   = var.peer_vpc_id_uat
  peer_region   = "us-east-1"
  auto_accept   = true
  vpc_id        = aws_vpc.main.id
}

resource "aws_vpc_peering_connection" "dev_peer" {
  peer_owner_id = var.prod_account_id
  peer_vpc_id   = var.peer_vpc_id_prod
  peer_region   = "us-east-1"
  auto_accept   = true
  vpc_id        = aws_vpc.main.id
}
