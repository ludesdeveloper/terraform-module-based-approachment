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
