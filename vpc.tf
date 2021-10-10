resource "aws_vpc" "aws-vpc" {
  cidr_block           = "172.31.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  enable_classiclink   = false
  instance_tenancy     = "default"

  tags = {
    "Name" = "aws-vpc"
  }
}

resource "aws_subnet" "aws-subnet-public-1" {
  vpc_id                  = aws_vpc.aws-vpc.id
  cidr_block              = "172.31.0.0/20"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1a"

  tags = {
    "Name" = "aws-subnet-public-1"
  }
}

resource "aws_subnet" "aws-subnet-public-2" {
  vpc_id                  = aws_vpc.aws-vpc.id
  cidr_block              = "172.31.16.0/20"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1b"

  tags = {
    "Name" = "aws-subnet-public-2"
  }
}

resource "aws_subnet" "aws-subnet-public-3" {
  vpc_id                  = aws_vpc.aws-vpc.id
  cidr_block              = "172.31.32.0/20"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1c"

  tags = {
    "Name" = "aws-subnet-public-3"
  }
}

resource "aws_internet_gateway" "aws-igw" {
  vpc_id = aws_vpc.aws-vpc.id

  tags = {
    "Name" = "aws-igw"
  }
}

resource "aws_route_table" "aws-public-crt" {
  vpc_id = aws_vpc.aws-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws-igw.id
  }

  tags = {
    Name = "aws-public-crt"
  }
}

resource "aws_route_table_association" "aws-crta-public-subnet-1" {
  subnet_id      = aws_subnet.aws-subnet-public-1.id
  route_table_id = aws_route_table.aws-public-crt.id
}

resource "aws_route_table_association" "aws-crta-public-subnet-2" {
  subnet_id      = aws_subnet.aws-subnet-public-2.id
  route_table_id = aws_route_table.aws-public-crt.id
}

resource "aws_route_table_association" "aws-crta-public-subnet-3" {
  subnet_id      = aws_subnet.aws-subnet-public-3.id
  route_table_id = aws_route_table.aws-public-crt.id
}

resource "aws_security_group" "aws-all" {
  vpc_id = aws_vpc.aws-vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "aws-all"
  }
}