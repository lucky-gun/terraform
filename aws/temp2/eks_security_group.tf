## Security Group
resource "aws_security_group" "eks_cluster" {
  name        = "${local.cluster_name}-cluster-sg"
  description = "Security group for EKS control plane"
  vpc_id      = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name = "${local.cluster_name}-cluster-sg"
  })
}

resource "aws_security_group" "eks_node" {
  name        = "${local.cluster_name}-node-sg"
  description = "Security group for EKS worker nodes"
  vpc_id      = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name = "${local.cluster_name}-node-sg"
  })
}

# worker node -> control plane (443)
resource "aws_security_group_rule" "eks_cluster_ingress_https_nodes" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_cluster.id
  source_security_group_id = aws_security_group.eks_node.id
  description              = "EKS worker nodes connect to control plane (api server)"
}

# control plane -> worker node
resource "aws_security_group_rule" "eks_node_ingress_all_cluster" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.eks_node.id
  source_security_group_id = aws_security_group.eks_cluster.id
  description              = "EKS control plane connect to worker nodes (ALL)"
}

# node <-> node
resource "aws_security_group_rule" "eks_node_ingress_self" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.eks_node.id
  source_security_group_id = aws_security_group.eks_node.id
  description              = "EKS Node communication"
}

# egress rule
resource "aws_security_group_rule" "eks_cluster_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.eks_cluster.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "EKS control plane outbound traffic (ALL)"
}

resource "aws_security_group_rule" "eks_node_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.eks_node.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "EKS worker nodes outbound traffic (ALL)"
}
