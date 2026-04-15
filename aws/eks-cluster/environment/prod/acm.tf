module "acm" {
  source = "../../modules/acm"
  domain_name = "lucky-gun.com"
  validation_method = "DNS"
  tags = merge(local.common_tags, {
    Name = local.eks_cluster_name
  })
  depends_on = [
    module.eks
  ]
}
