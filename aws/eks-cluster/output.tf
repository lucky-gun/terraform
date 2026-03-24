output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id
  ]
}

output "private_subnet_ids" {
  value = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id
  ]
}

output "internet_gateway_id" {
  value = aws_internet_gateway.main.id
}

output "nat_gateway_a_id" {
  value = aws_nat_gateway.a.id
}

output "nat_gateway_b_id" {
  value = aws_nat_gateway.b.id
}

output "public_route_table_id" {
  value = aws_route_table.public.id
}

output "private_route_table_a_id" {
  value = aws_route_table.private_a.id
}

output "private_route_table_b_id" {
  value = aws_route_table.private_b.id
}

output "eks_cluster_name" {
  value = aws_eks_cluster.main.name
}

output "eks_cluster_arn" {
  value = aws_eks_cluster.main.arn
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.main.endpoint
}

output "eks_cluster_version" {
  value = aws_eks_cluster.main.version
}

output "eks_cluster_oidc_issuer" {
  value = aws_eks_cluster.main.identity[0].oidc[0].issuer
}

output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster.arn
}

output "eks_node_role_arn" {
  value = aws_iam_role.eks_node.arn
}

output "eks_cluster_security_group_id" {
  value = aws_security_group.eks_cluster.id
}

output "eks_node_security_group_id" {
  value = aws_security_group.eks_node.id
}

output "eks_private_subnet_ids_for_cluster" {
  value = sort(data.aws_subnets.eks_private.ids)
}
