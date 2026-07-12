# IAM Role for Worker Nodes

resource "aws_iam_role" "eks_node_role" {

  name = "eks-prod-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "eks-prod-node-role"
  }
}

# IAM Policy Attachments

resource "aws_iam_role_policy_attachment" "worker_node_policy" {

  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "cni_policy" {

  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "ecr_policy" {

  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

# Managed Node Group

resource "aws_eks_node_group" "eks_prod_node_group" {

  cluster_name    = aws_eks_cluster.eks_prod_cluster.name
  node_group_name = "eks-prod-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn

  subnet_ids = [
    aws_subnet.private_subnet_a.id,
    aws_subnet.private_subnet_b.id
  ]

  capacity_type = "ON_DEMAND"

  instance_types = [
    "t3.medium"
  ]

  ami_type = "AL2023_x86_64_STANDARD"

  scaling_config {

    desired_size = 2
    min_size     = 2
    max_size     = 4

  }

  update_config {

    max_unavailable = 1

  }

  depends_on = [

    aws_iam_role_policy_attachment.worker_node_policy,
    aws_iam_role_policy_attachment.cni_policy,
    aws_iam_role_policy_attachment.ecr_policy

  ]

  tags = {
    Name = "eks-prod-node-group"
  }
}
