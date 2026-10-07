resource "aws_db_instance" "fider-db" {
  db_name = "fider-db"
  allocated_storage = 20
  storage_type = "gp3"
  engine = "postgres"
  engine_version = "17.5"
  instance_class = "db.t3.micro"
  db_subnet_group_name = aws_db_subnet_group.private-fider-db-subnet.name
}

resource "aws_db_subnet_group" "private-fider-db-subnet" {
  name = "private-fider-db-subnet"
  subnet_ids = var.private_subnet_ids
}

