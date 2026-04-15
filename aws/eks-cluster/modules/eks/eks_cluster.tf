resource "aws_eks_cluster" "main" {
  name = var.cluster_name
  role_arn = var.cluster_role_arn
  version = var.cluster_version

  vpc_config {
    subnet_ids              = var.vpc_config.subnet_ids
    security_group_ids      = var.vpc_config.security_group_ids
    endpoint_private_access = var.vpc_config.endpoint_private_access
    endpoint_public_access  = var.vpc_config.endpoint_public_access
    public_access_cidrs     = var.vpc_config.public_access_cidrs
  }

  enabled_cluster_log_types = var.enabled_cluster_log_types

  tags = var.tags
}
