resource "aws_security_group" "ingress" {
  for_each = var.ingress_security_groups

  name        = each.value.description
  description = each.value.description
  vpc_id      = var.sg_vpc_id
  ingress {
    description = each.value.description
    from_port   = each.value.from_port
    to_port     = each.value.to_port
    protocol    = each.value.protocol
    cidr_blocks = each.value.cidr_blocks
  }

  tags = {
    Name = each.value.description
  }
}

resource "aws_security_group" "egress" {
  for_each = var.egress_security_groups

  name        = each.value.description
  description = each.value.description
  vpc_id      = var.sg_vpc_id
  ingress {
    description = each.value.description
    from_port   = each.value.from_port
    to_port     = each.value.to_port
    protocol    = each.value.protocol
    cidr_blocks = each.value.cidr_blocks
  }

  tags = {
    Name = each.value.description
  }
}
