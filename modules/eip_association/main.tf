resource "aws_eip_association" "eip_association" {
  count         = length(var.eip_association_count)
  instance_id   = var.instance_id[count.index]
  allocation_id = var.eip_id[count.index]
}
