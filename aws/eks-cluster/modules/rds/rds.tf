resource "aws_db_subnet_group" "sg" {
  name       = "rds-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "db" {
  identifier         = var.identifier
  engine             = var.engine
  instance_class     = var.instance_class
  allocated_storage  = var.allocated_storage

  db_name  = var.db_name
  username = var.username
  password = var.password

  vpc_security_group_ids = var.security_group_ids
  db_subnet_group_name   = aws_db_subnet_group.sg.name

  skip_final_snapshot = true
}

