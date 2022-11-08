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

module "vpc_subnet" {
  source              = "./modules/vpc_subnet"
  vpc_id              = module.vpc.vpc_id
  name                = "cloud-subnet"
  public_subnet       = ["172.14.30.0/24"]
  internet_gateway_id = module.vpc_internet_gateway.internet_gateway_id
}

module "security_group" {
  source         = "./modules/security_group"
  vpc_id         = module.vpc.vpc_id
  name           = "my-security-group"
  security_group = var.security_group
}

module "k3s" {
  source            = "./modules/ec2"
  instance_name     = ["k3s-master", "k3s-slave-1", "k3s-slave-2"]
  key_name          = aws_key_pair.key_pair.key_name
  ami_owner         = ["099720109477"]
  ami_value         = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
  instance_type     = "t2.micro"
  subnet_id         = module.vpc_subnet.public_subnet_id[0]
  security_group_id = [module.security_group.security_group_id]
  private_ip        = ["172.14.30.10", "172.14.30.11", "172.14.30.12"]
}

module "eip" {
  eip_count = module.k3s.instance_id
  source    = "./modules/eip"
}

module "eip_association" {
  eip_association_count = module.k3s.instance_id
  source                = "./modules/eip_association"
  eip_id                = module.eip.eip_id
  instance_id           = module.k3s.instance_id
}
