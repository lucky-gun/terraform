resource "aws_eks_node_group" "workers" {
  cluster_name    = var.cluster_name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.vpc_config.subnet_ids

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  #remote_access {
  #  ec2_ssh_key = var.ssh_key_name
  #}

  #ami_type  = "AL2_x86_64"
  #disk_size = 20

  tags = var.tags

  depends_on = [ aws_eks_cluster.main ]
}
