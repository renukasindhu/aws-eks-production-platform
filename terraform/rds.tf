# DB Subnet Group

resource "aws_db_subnet_group" "eks_prod_db_subnet_group" {

  name = "eks-prod-db-subnet-group"

  subnet_ids = [
    aws_subnet.private_subnet_a.id,
    aws_subnet.private_subnet_b.id
  ]

  tags = {
    Name = "eks-prod-db-subnet-group"
  }
}

# RDS Instance

resource "aws_db_instance" "eks_prod_rds" {

  identifier = var.db_identifier

  engine         = var.db_engine
  engine_version = var.db_engine_version

  instance_class = var.db_instance_class

  allocated_storage = var.db_allocated_storage
  storage_type      = var.db_storage_type

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  db_subnet_group_name = aws_db_subnet_group.eks_prod_db_subnet_group.name

  vpc_security_group_ids = [
    aws_security_group.eks_rds_sg.id
  ]

  publicly_accessible = false

  multi_az = false

  storage_encrypted = true

  backup_retention_period = 1

  auto_minor_version_upgrade = true

  deletion_protection = false

  skip_final_snapshot = true

  apply_immediately = true

  tags = {
    Name = "datastore-db"
  }
}
