module "eks_security_group" {
  source = "../../modules/security_group"

  eks = {
    cluster_name  = local.cluster_name
  }

}
