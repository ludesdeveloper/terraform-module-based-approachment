data "aws_ami" "ami" {
  owners      = var.ami_owners
  most_recent = true
  filter {
    name   = "name"
    values = [var.ami_values]
  }
}

module "security_group" {
  source    = "./modules/security_group"
  sg_vpc_id = var.vpc_id
}

resource "aws_instance" "instance" {
  count                  = var.count_instance
  ami                    = data.aws_ami.ami.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = module.security_group.security_group_id
  #network_interface {
  #  network_interface_id = var.network_interface_id
  #  device_index         = 0
  #}
  tags = {
    Name = "instance"
  }
}
