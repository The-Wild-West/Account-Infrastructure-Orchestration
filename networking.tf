resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    vpc_type = "root_vpc"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true         
  tags = {
    Name = "public-subnet"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "sg" {
  name        = "root_sg"
  vpc_id      = aws_vpc.main.id
  description = "main sg in the root account"

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_vpc_peering_connection" "dev_peer" {
  peer_owner_id = var.dev_account_id
  peer_vpc_id   = var.peer_vpc_id_dev
  vpc_id        = aws_vpc.main.id
}

resource "aws_vpc_peering_connection_accepter" "dev_peer_accepter" {
  vpc_peering_connection_id = aws_vpc_peering_connection.dev_peer.id
  auto_accept               = true
}

resource "aws_vpc_peering_connection" "uat_peer" {
  peer_owner_id = var.uat_account_id
  peer_vpc_id   = var.peer_vpc_id_uat
  vpc_id        = aws_vpc.main.id
}

resource "aws_vpc_peering_connection_accepter" "uat_peer_accepter" {
  vpc_peering_connection_id = aws_vpc_peering_connection.uat_peer.id
  auto_accept               = true
}

resource "aws_vpc_peering_connection" "prod_peer" {
  peer_owner_id = var.prod_account_id
  peer_vpc_id   = var.peer_vpc_id_prod
  vpc_id        = aws_vpc.main.id
  
}

resource "aws_vpc_peering_connection_accepter" "prod_peer_acceptor" {
  vpc_peering_connection_id = aws_vpc_peering_connection.prod_peer.id
  auto_accept               = true
}
