variable "cidr" {}
variable "name" {}
variable "private_subnet" {}
variable "public_subnet" {}
variable "subnet_name" {}
variable "availability_zone" {
  default = null
}
variable "nat_gateway_id" {
  default = null
}
