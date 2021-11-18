resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "subnet" {
  count      = length(var.subnet_cidr)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet_cidr[count.index]

  tags = {
    Name = var.subnet_cidr[count.index]
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
  route_table_id = aws_route_table.route_table.id
  #subnet_id      = aws_subnet.subnet[0].id
  subnet_id = var.route_subnet_id
}
