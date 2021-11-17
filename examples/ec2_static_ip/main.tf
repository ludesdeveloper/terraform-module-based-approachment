provider "aws" {
  region = var.region
}

resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = file(var.public_key_file)
}

module "vpc" {
  source      = "./modules/vpc"
  vpc_cidr    = "172.14.0.0/16"
  vpc_name    = "vpc1"
  subnet_cidr = "172.14.10.0/24"
  subnet_name = "subnet1"
}

module "security_group" {
  source             = "./modules/security_group"
  sg_vpc_id          = module.vpc.vpc_id
  sg_name            = "my-security-group"
  sg_security_groups = var.security_groups
}

module "ec2" {
  source                = "./modules/ec2"
  instance_name         = "instance1"
  key_name              = aws_key_pair.key_pair.key_name
  ami_owners            = ["099720109477"]
  ami_values            = "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"
  count_instance        = 1
  instance_type         = "t2.micro"
  subnet_id             = module.vpc.subnet_id
  ec2_security_group_id = module.security_group.security_group_id
  private_ip            = "172.14.10.20"
}
