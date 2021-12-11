resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "private_subnet" {
  count             = length(var.private_subnet)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet[count.index]
  availability_zone = var.vpc_availability_zone
  tags = {
    Name = var.private_subnet[count.index]
  }
}

resource "aws_subnet" "public_subnet" {
  count             = length(var.public_subnet)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet[count.index]
  availability_zone = var.vpc_availability_zone
  tags = {
    Name = var.public_subnet[count.index]
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_route_table_association" "route_assoc" {
  count          = length(aws_subnet.public_subnet)
  route_table_id = aws_route_table.route_table.id
  subnet_id      = aws_subnet.public_subnet[count.index].id
}
