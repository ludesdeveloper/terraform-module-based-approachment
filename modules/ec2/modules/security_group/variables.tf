variable "sg_vpc_id" {}

variable "ingress_security_groups" {
  description = "Map of ingress security groups"
  type        = map(any)
  default = {
    ssh = {
      description = "ssh"
      protocol    = "tcp"
      from_port   = 22
      to_port     = 22
      cidr_blocks = ["0.0.0.0/0"]
    },
    web = {
      description = "web"
      protocol    = "tcp"
      from_port   = 80
      to_port     = 80
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

variable "egress_security_groups" {
  description = "Map of egress security groups"
  type        = map(any)
  default = {
    ssh = {
      description = "all"
      protocol    = -1
      from_port   = 0
      to_port     = 0
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
