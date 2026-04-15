module "irsa" {
  source = "../../modules/iam/irsa"

  cluster_name = local.eks_cluster_name
  oidc_provider_arn = module.oidc.oidc_provider_arn

  oidc_provider_url = replace(
    module.eks.oidc_issuer_url,
    "https://",
    ""
  )

  irsa = {
    ebs_csi = {
      namespace = "kube-system"
      sa_name = "aws-ebs-csi-driver"

      policy_arns = [
        "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
      ]
    }

    lbc = {
      namespace = "kube-system"
      sa_name = "aws-load-balancer-controller"

      policy_json = file("${path.module}/json/lbc_iam_policy.json")
    }
  }
  depends_on = [module.eks]
}
