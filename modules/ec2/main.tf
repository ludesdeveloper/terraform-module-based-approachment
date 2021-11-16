data "aws_ami" "ami" {
  owners      = var.ami_owners
  most_recent = true
  filter {
    name   = "name"
    values = [var.ami_values]
  }
}



resource "aws_instance" "instance" {
  count         = var.count_instance
  ami           = data.aws_ami.ami.id
  instance_type = var.instance_type
  key_name      = var.key_name
  tags = {
    Name = "instance"
  }
}
