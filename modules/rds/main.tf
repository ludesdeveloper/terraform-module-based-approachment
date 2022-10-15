resource "aws_db_instance" "default" {
  allocated_storage = 10
  db_name           = "mydb"
  engine            = "mariadb"
  engine_version    = "10.5"
  instance_class    = "db.t3.micro"
  username          = "foo"
  password          = "foobarbaz"
  # parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  db_subnet_group_name = var.subnet_group
  availability_zone    = "ap-southeast-1a"
}
