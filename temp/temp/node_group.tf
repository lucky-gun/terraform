resource "aws_eks_node_group" "workers" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${local.cluster_name}-node-group"
  node_role_arn   = aws_iam_role.eks_node.arn
  subnet_ids      = sort(data.aws_subnets.eks_private.ids)

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  tags = merge(local.common_tags, {
    Name = "${local.cluster_name}-node-group"
  })

  depends_on = [
    aws_eks_cluster.main
  ]
}
