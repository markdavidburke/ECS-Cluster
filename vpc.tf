### Network

# Internet VPC

resource "aws_vpc" "demo-tf" {
  cidr_block           = "172.21.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags = {
    Name = "demo-terraform"
  }
}

# Subnets
resource "aws_subnet" "demo-public-1" {
  vpc_id                  = aws_vpc.demo-tf.id
  cidr_block              = "172.21.10.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-west-2a"

  tags = {
    Name = "demo-public-1"
  }
}

resource "aws_subnet" "demo-public-2" {
  vpc_id                  = aws_vpc.demo-tf.id
  cidr_block              = "172.21.20.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-west-2b"

  tags = {
    Name = "demo-public-2"
  }
}

resource "aws_subnet" "demo-public-3" {
  vpc_id                  = aws_vpc.demo-tf.id
  cidr_block              = "172.21.30.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-west-2c"

  tags = {
    Name = "demo-public-3"
  }
}

resource "aws_subnet" "demo-private-1" {
  vpc_id                  = aws_vpc.demo-tf.id
  cidr_block              = "172.21.40.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "eu-west-2a"

  tags = {
    Name = "demo-private-1"
  }
}

resource "aws_subnet" "demo-private-2" {
  vpc_id                  = aws_vpc.demo-tf.id
  cidr_block              = "172.21.50.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "eu-west-2b"

  tags = {
    Name = "demo-private-2"
  }
}

resource "aws_subnet" "demo-private-3" {
  vpc_id                  = aws_vpc.demo-tf.id
  cidr_block              = "172.21.60.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "eu-west-2c"

  tags = {
    Name = "demo-private-3"
  }
}

# Internet GW
resource "aws_internet_gateway" "demo-gw" {
  vpc_id = aws_vpc.demo-tf.id

  tags = {
    Name = "demo-IG"
  }
}

# route tables
resource "aws_route_table" "demo-public" {
  vpc_id = aws_vpc.demo-tf.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo-gw.id
  }

  tags = {
    Name = "demo-public-1"
  }
}

# route associations public
resource "aws_route_table_association" "demo-public-1-a" {
  subnet_id      = aws_subnet.demo-public-1.id
  route_table_id = aws_route_table.demo-public.id
}

resource "aws_route_table_association" "demo-public-2-a" {
  subnet_id      = aws_subnet.demo-public-2.id
  route_table_id = aws_route_table.demo-public.id
}

resource "aws_route_table_association" "demo-public-3-a" {
  subnet_id      = aws_subnet.demo-public-3.id
  route_table_id = aws_route_table.demo-public.id
}

