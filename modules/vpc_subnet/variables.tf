variable "vpc_id" {}
variable "name" {}
variable "private_subnet" {
  default = []
}
variable "public_subnet" {
  default = []
}
# variable "subnet_name" {}
variable "availability_zone" {
  default = null
}
variable "nat_gateway_id" {
  default = null
}
variable "internet_gateway_id" {}
