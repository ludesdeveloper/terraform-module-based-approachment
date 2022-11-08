data "aws_ami" "ami" {
  owners      = var.ami_owner
  most_recent = true
  filter {
    name   = "name"
    values = [var.ami_value]
  }
}

resource "aws_instance" "instance" {
  count                  = length(var.instance_name)
  ami                    = data.aws_ami.ami.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  private_ip             = var.private_ip[count.index]
  vpc_security_group_ids = var.security_group_id
  iam_instance_profile   = var.iam_instance_profile
  tags = {
    Name = var.instance_name[count.index]
  }
}
