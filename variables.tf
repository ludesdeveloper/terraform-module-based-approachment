variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "key_name" {
  type    = string
  default = "ec2-keypair"
}

variable "public_key_file" {
  type    = string
  default = "scripts/ec2-keypair.pub"
}
