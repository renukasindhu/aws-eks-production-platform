variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "project_name" {
  description = "Project Name"
  type        = string
}

# Networking Variables

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "public_subnet_1_cidr" {
  type = string
}

variable "public_subnet_2_cidr" {
  type = string
}

variable "private_subnet_1_cidr" {
  type = string
}

variable "private_subnet_2_cidr" {
  type = string
}

# RDS Variables

variable "db_identifier" {
  description = "RDS Instance Identifier"
  type        = string
}

variable "db_name" {
  description = "Database Name"
  type        = string
}

variable "db_username" {
  description = "Master Username"
  type        = string
}

variable "db_password" {
  description = "Master Password"
  type        = string
  sensitive   = true
}

variable "db_engine" {
  description = "Database Engine"
  type        = string
}

variable "db_engine_version" {
  description = "Database Engine Version"
  type        = string
}

variable "db_instance_class" {
  description = "RDS Instance Type"
  type        = string
}

variable "db_allocated_storage" {
  description = "Allocated Storage"
  type        = number
}

variable "db_storage_type" {
  description = "Storage Type"
  type        = string
}
