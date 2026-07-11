# VPC

resource "aws_vpc" "eks_prod_vpc" {

  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# Internet Gateway

resource "aws_internet_gateway" "eks_prod_igw" {

  vpc_id = aws_vpc.eks_prod_vpc.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

# Public Subnet A

resource "aws_subnet" "public_subnet_a" {

  vpc_id                  = aws_vpc.eks_prod_vpc.id
  cidr_block              = var.public_subnet_1_cidr
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-subnet-a"
  }
}

# Public Subnet B

resource "aws_subnet" "public_subnet_b" {

  vpc_id                  = aws_vpc.eks_prod_vpc.id
  cidr_block              = var.public_subnet_2_cidr
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-subnet-b"
  }
}

# Private Subnet A

resource "aws_subnet" "private_subnet_a" {

  vpc_id            = aws_vpc.eks_prod_vpc.id
  cidr_block        = var.private_subnet_1_cidr
  availability_zone = "ap-south-1a"

  tags = {
    Name = "${var.project_name}-private-subnet-a"
  }
}

# Private Subnet B

resource "aws_subnet" "private_subnet_b" {

  vpc_id            = aws_vpc.eks_prod_vpc.id
  cidr_block        = var.private_subnet_2_cidr
  availability_zone = "ap-south-1b"

  tags = {
    Name = "${var.project_name}-private-subnet-b"
  }
}

# Elastic IP

resource "aws_eip" "eks_prod_eip" {

  domain = "vpc"

  tags = {
    Name = "${var.project_name}-nat-eip"
  }
}

# NAT Gateway

resource "aws_nat_gateway" "eks_prod_nat" {

  allocation_id = aws_eip.eks_prod_eip.id
  subnet_id     = aws_subnet.public_subnet_a.id

  depends_on = [
    aws_internet_gateway.eks_prod_igw
  ]

  tags = {
    Name = "${var.project_name}-nat"
  }
}

# Public Route Table

resource "aws_route_table" "public_rt" {

  vpc_id = aws_vpc.eks_prod_vpc.id

  route {

    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.eks_prod_igw.id
  }

  tags = {
    Name = "${var.project_name}-public-rt"
  }
}

# Private Route Table

resource "aws_route_table" "private_rt" {

  vpc_id = aws_vpc.eks_prod_vpc.id

  route {

    cidr_block = "0.0.0.0/0"

    nat_gateway_id = aws_nat_gateway.eks_prod_nat.id
  }

  tags = {
    Name = "${var.project_name}-private-rt"
  }
}

# Route Associations

resource "aws_route_table_association" "public_a" {

  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_b" {

  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_a" {

  subnet_id      = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_b" {

  subnet_id      = aws_subnet.private_subnet_b.id
  route_table_id = aws_route_table.private_rt.id
}
