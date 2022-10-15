provider "aws" {
  region = var.region
}

resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = file(var.public_key_file)
}

module "vpc" {
  source = "./modules/vpc"
  cidr   = "172.14.0.0/16"
  name   = "vpc1"
}

module "vpc_internet_gateway" {
  source = "./modules/vpc_internet_gateway"
  vpc_id = module.vpc.vpc_id
  name   = "cloud-internet-gateway"
}

module "vpc_nat_gateway" {
  source           = "./modules/vpc_nat_gateway"
  internet_gateway = module.vpc_internet_gateway.internet_gateway
  name             = "cloud-nat-gateway"
  subnet_id        = module.vpc_subnet.private_subnet_id[0]
  eip_id           = module.eip.eip_id
}

module "vpc_subnet" {
  source = "./modules/vpc_subnet"
  vpc_id = module.vpc.vpc_id
  name   = "cloud-subnet"
  # public_subnet       = ["192.168.1.0/24"]
  # private_subnet      = ["192.168.2.0/24"]
  private_subnet      = ["172.14.20.0/24"]
  public_subnet       = ["172.14.30.0/24"]
  internet_gateway_id = module.vpc_internet_gateway.internet_gateway_id
  nat_gateway_id      = module.vpc_nat_gateway.nat_gateway_id
}

module "security_group" {
  source         = "./modules/security_group"
  vpc_id         = module.vpc.vpc_id
  name           = "my-security-group"
  security_group = var.security_group
}

module "ec2_private" {
  source            = "./modules/ec2"
  instance_name     = "instance_private"
  key_name          = aws_key_pair.key_pair.key_name
  ami_owner         = ["099720109477"]
  ami_value         = "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"
  count_instance    = 1
  instance_type     = "t2.micro"
  subnet_id         = module.vpc_subnet.private_subnet_id[0]
  security_group_id = [module.security_group.security_group_id]
  private_ip        = "172.14.20.10"
}

module "ec2_public" {
  source         = "./modules/ec2"
  instance_name  = "instance_public"
  key_name       = aws_key_pair.key_pair.key_name
  ami_owner      = ["099720109477"]
  ami_value      = "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"
  count_instance = 1
  instance_type  = "t2.micro"
  # subnet_id         = module.vpc.public_subnet_id[0]
  subnet_id         = module.vpc_subnet.public_subnet_id[0]
  security_group_id = [module.security_group.security_group_id]
  private_ip        = null
}

module "eip" {
  source = "./modules/eip"
}
