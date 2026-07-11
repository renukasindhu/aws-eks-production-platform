output "vpc_id" {
  value = aws_vpc.eks_prod_vpc.id
}

output "public_subnet_1" {
  value = aws_subnet.public_subnet_a.id
}

output "public_subnet_2" {
  value = aws_subnet.public_subnet_b.id
}

output "private_subnet_1" {
  value = aws_subnet.private_subnet_a.id
}

output "private_subnet_2" {
  value = aws_subnet.private_subnet_b.id
}
