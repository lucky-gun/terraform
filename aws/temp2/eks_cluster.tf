locals {
  cluster_name = "lucky-gun-eks"
  eks_version  = "1.33"

  # 내 접속용
  public_access_cidrs = ["116.37.149.145/32"]

  common_tags = {
    Project   = "terraform-eks-study"
    ManagedBy = "Terraform"
  }
}

# private subnet 자동 조회
# data "aws_subnets" "eks_private" {
#  filter {
#    name   = "vpc-id"
#    values = [aws_vpc.main.id]
#  }
#
#  tags = {
#    "kubernetes.io/role/internal-elb" = "1"
#  }
#}

resource "aws_eks_cluster" "main" {
  name     = local.cluster_name
  role_arn = aws_iam_role.eks_cluster.arn
  version  = local.eks_version

  vpc_config {
    subnet_ids              = [ aws_subnet.private_a.id, aws_subnet.private_b.id]
    #subnet_ids = sort(data.aws_subnets.eks_private.ids)
    security_group_ids      = [aws_security_group.eks_cluster.id]
    endpoint_private_access = true
    endpoint_public_access  = true
    public_access_cidrs     = local.public_access_cidrs
  }

  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator"
  ]

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_AmazonEKSClusterPolicy
  ]

  tags = merge(local.common_tags, {
    Name = local.cluster_name
  })
}
