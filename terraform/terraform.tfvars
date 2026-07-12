aws_region = "ap-south-1"

project_name = "eks-prod"

vpc_cidr = "10.0.0.0/16"

public_subnet_1_cidr = "10.0.1.0/24"
public_subnet_2_cidr = "10.0.2.0/24"

private_subnet_1_cidr = "10.0.3.0/24"
private_subnet_2_cidr = "10.0.4.0/24"

# RDS

db_username          = "admin"
db_identifier        = "datastore-db"
db_name              = "studentdb"
db_engine            = "mysql"
db_engine_version    = "8.4.9"
db_instance_class    = "db.t4g.micro"
db_allocated_storage = 20
db_storage_type      = "gp2"
db_password          = "eksproddb1234567"
