variable "sg_vpc_id" {}
variable "sg_name" {}

variable "security_groups" {
  description = "Map of ingress security groups"
  type        = map(any)
  default = {
    ssh = {
      type        = "ingress"
      description = "ssh"
      protocol    = "tcp"
      from_port   = 22
      to_port     = 22
      cidr_blocks = ["0.0.0.0/0"]
    },
    web = {
      type        = "ingress"
      description = "web"
      protocol    = "tcp"
      from_port   = 80
      to_port     = 80
      cidr_blocks = ["0.0.0.0/0"]
    },
    all = {
      type        = "egress"
      description = "all"
      protocol    = -1
      from_port   = 0
      to_port     = 0
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
