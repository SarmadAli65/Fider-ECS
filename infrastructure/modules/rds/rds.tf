resource "aws_db_instance" "fider-db" {
  username = var.db_username
  password = var.db_password
  db_name = "fider"
  allocated_storage = 20
  storage_type = "gp3"
  engine = "postgres"
  engine_version = "17"
  instance_class = "db.t3.micro"
  db_subnet_group_name = aws_db_subnet_group.private-fider-db-subnet.name
  vpc_security_group_ids = [ aws_security_group.rds_sg.id ]
  skip_final_snapshot = true
  multi_az = true
}

resource "aws_db_subnet_group" "private-fider-db-subnet" {
  name = "private-fider-db-subnet"
  subnet_ids = var.private_subnet_ids
}

resource "aws_security_group" "rds_sg" {
    name = "rds_sg"
    vpc_id = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "allow_ecs_tasks" {
    security_group_id = aws_security_group.rds_sg.id
    referenced_security_group_id = var.ecs_sg_id
    ip_protocol = "tcp"
    from_port = 5432
    to_port = 5432
}

resource "aws_vpc_security_group_egress_rule" "rds-egress-rule" {
  security_group_id = aws_security_group.rds_sg.id
  ip_protocol = "-1"
  cidr_ipv4 = "0.0.0.0/0"
}
