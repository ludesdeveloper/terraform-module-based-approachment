resource "aws_vpc" "vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "tf-example"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "172.16.10.0/24"

  tags = {
    Name = "tf-example"
  }
}

resource "aws_network_interface" "network_interface" {
  subnet_id   = aws_subnet.subnet.id
  private_ips = ["172.16.10.20"]
  tags = {
    Name = "tf-example"
  }
}
