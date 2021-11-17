data "aws_ami" "ami" {
  owners      = var.ami_owners
  most_recent = true
  filter {
    name   = "name"
    values = [var.ami_values]
  }
}

resource "aws_instance" "instance" {
  count                  = var.count_instance
  ami                    = data.aws_ami.ami.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  private_ip             = var.private_ip
  vpc_security_group_ids = var.ec2_security_group_id
  tags = {
    Name = var.instance_name
  }
}
