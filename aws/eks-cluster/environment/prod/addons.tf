module "ebs_csi" {
  source = "../../modules/addons/ebs-csi"
  irsa_role_arn = module.irsa.irsa_role_arns["ebs_csi"]
  sa_name = "aws-ebs-csi-driver"
  namespace = "kube-system"
  depends_on = [
    module.eks,
    module.main_network
  ]
}

module "lbc" {
  source = "../../modules/addons/lbc"
  irsa_role_arn = module.irsa.irsa_role_arns["lbc"]
  sa_name = "aws-load-balancer-controller"
  namespace = "kube-system"
  cluster_name = local.eks_cluster_name
  vpc_id = module.main_network.vpc_id
  depends_on = [
    module.eks,
    module.main_network
  ]
}

module "haproxy" {
  source = "../../modules/addons/ha-proxy"
  namespace = "ingress-controller"
  values = [
    file("${path.module}/values/haproxy-values.yaml")
  ]
  depends_on = [
    module.eks,
    module.main_network
  ]
}

module "cert_manager" {
  source = "../../modules/addons/cert-manager"
  namespace = "cert-manager"
  depends_on = [
    module.eks,
    module.main_network
  ]
}
