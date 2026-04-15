module "iam" {
  source = "../../modules/iam"

  iam_roles = {
    eks_cluster = {
      name = "${local.eks_cluster_name}-cluster-role"

      assume_role_policy = [
      {
        effect = "Allow"
        actions = ["sts:AssumeRole"]
        principals = {
          type        = "Service"
          identifiers = ["eks.amazonaws.com"]
        }
      }]  
      policy_arns = [
        "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
      ]
      tags = merge(local.common_tags, {
        Service = "eks"
      })
    }

    eks_node = {
      name = "${local.eks_cluster_name}-node-role"

      assume_role_policy = [
      {
        effect = "Allow"
        actions = ["sts:AssumeRole"]
        principals = {
          type        = "Service"
          identifiers = ["ec2.amazonaws.com"]
        }
      }]  
      policy_arns = [
        "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
        "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPullOnly",
        "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
      ]
      tags = merge(local.common_tags, {
        Service = "eks"
      })
    }
  }
}
