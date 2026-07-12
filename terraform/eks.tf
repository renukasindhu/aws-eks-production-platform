# IAM Role for EKS Cluster

resource "aws_iam_role" "eks_cluster_role" {

  name = "eks-prod-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "eks.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "eks-prod-cluster-role"
  }
}

# Attach EKS Cluster Policy

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {

  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# EKS Cluster

resource "aws_eks_cluster" "eks_prod_cluster" {

  name     = "eks-prod-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  version = "1.33"

  vpc_config {

    subnet_ids = [
      aws_subnet.private_subnet_a.id,
      aws_subnet.private_subnet_b.id
    ]

    security_group_ids = [
      aws_security_group.eks_cluster_sg.id
    ]

    endpoint_private_access = true
    endpoint_public_access  = true

  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]

  tags = {
    Name = "eks-prod-cluster"
  }
}
