module "eks_iam" {
  source = "../../modules/iam"

  iam_roles = {
    eks_cluster = {
      name = "${local.cluster_name}-cluster-role"

      assume_role = {
        type        = "Service"
        identifiers = ["eks.amazonaws.com"]
      }

      policy_arns = [
        "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
      ]

      tags = {
        Service = "eks"
      }
    }

    eks_node = {
      name = "${local.cluster_name}-node-role"

      assume_role = {
        type        = "Service"
        identifiers = ["ec2.amazonaws.com"]
      }

      policy_arns = [
        "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
        "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPullOnly",
        "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
      ]

      tags = {
        Service = "eks"
      }
    }
  }
}

module "lbc_iam" {
  source = "../../modules/iam"

  iam_roles = {
    lbc = {
      name = "aws-load-balancer-controller"

      assume_role = {
        type        = "Federated"
        identifiers = ["arn:aws:iam::123456789:oidc-provider/..."]
      }

      policy_arns = []

      inline_policies = {
        lbc_policy = file("${path.module}/iam_policy.json")
      }
    }
  }
}
