data "aws_ami" "ami" {
  owners      = var.ami_owners
  most_recent = true
  filter {
    name   = "name"
    values = [var.ami_values]
  }
}

module "security_group" {
  source = "./modules/security_group"
}

resource "aws_instance" "instance" {
  count                  = var.count_instance
  ami                    = data.aws_ami.ami.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = module.security_group.security_group_id
  tags = {
    Name = "instance"
  }
}
