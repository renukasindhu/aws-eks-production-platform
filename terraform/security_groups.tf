# EKS Cluster Security Group

resource "aws_security_group" "eks_cluster_sg" {

  name        = "eks-prod-cluster-sg"
  description = "Security Group for EKS Control Plane"
  vpc_id      = aws_vpc.eks_prod_vpc.id

  tags = {
    Name = "eks-prod-cluster-sg"
  }
}

# Worker Node Security Group

resource "aws_security_group" "eks_node_sg" {

  name        = "eks-prod-node-sg"
  description = "Security Group for EKS Worker Nodes"
  vpc_id      = aws_vpc.eks_prod_vpc.id

  tags = {
    Name = "eks-prod-node-sg"
  }
}

# RDS Security Group

resource "aws_security_group" "eks_rds_sg" {

  name        = "eks-prod-rds-sg"
  description = "Security Group for MySQL Database"
  vpc_id      = aws_vpc.eks_prod_vpc.id

  tags = {
    Name = "eks-prod-rds-sg"
  }
}

# Cluster SG Rules

resource "aws_security_group_rule" "cluster_ingress_https" {

  type      = "ingress"
  from_port = 443
  to_port   = 443
  protocol  = "tcp"

  security_group_id        = aws_security_group.eks_cluster_sg.id
  source_security_group_id = aws_security_group.eks_node_sg.id
}

resource "aws_security_group_rule" "cluster_egress" {

  type      = "egress"
  from_port = 0
  to_port   = 0
  protocol  = "-1"

  security_group_id = aws_security_group.eks_cluster_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

# Worker Node SG Rules

resource "aws_security_group_rule" "node_ingress_self" {

  type      = "ingress"
  from_port = 0
  to_port   = 65535
  protocol  = "tcp"

  security_group_id = aws_security_group.eks_node_sg.id
  self              = true
}

resource "aws_security_group_rule" "node_ingress_cluster" {

  type      = "ingress"
  from_port = 1025
  to_port   = 65535
  protocol  = "tcp"

  security_group_id        = aws_security_group.eks_node_sg.id
  source_security_group_id = aws_security_group.eks_cluster_sg.id
}

resource "aws_security_group_rule" "node_egress" {

  type      = "egress"
  from_port = 0
  to_port   = 0
  protocol  = "-1"

  security_group_id = aws_security_group.eks_node_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

# RDS SG Rules

resource "aws_security_group_rule" "rds_ingress_mysql" {

  type      = "ingress"
  from_port = 3306
  to_port   = 3306
  protocol  = "tcp"

  security_group_id        = aws_security_group.eks_rds_sg.id
  source_security_group_id = aws_security_group.eks_node_sg.id
}

resource "aws_security_group_rule" "rds_egress" {

  type      = "egress"
  from_port = 0
  to_port   = 0
  protocol  = "-1"

  security_group_id = aws_security_group.eks_rds_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}
