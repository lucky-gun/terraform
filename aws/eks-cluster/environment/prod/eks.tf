module "eks" {
  source = "../../modules/eks"

  cluster_name = local.eks_cluster_name
  cluster_version = "1.35"
  cluster_role_arn = module.iam.iam_role_arns["eks_cluster"]
  node_role_arn = module.iam.iam_role_arns["eks_node"]
  vpc_config = {
    subnet_ids = module.main_network.subnets_id_by_type["private"]
    security_group_ids = [module.eks_security_group.security_groups["eks_cluster"].id]
    public_access_cidrs = ["116.37.149.145/32"]
  }

  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator"
  ]

  tags = merge(local.common_tags, {
    Name = local.eks_cluster_name
  })
}
