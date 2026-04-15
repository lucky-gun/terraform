resource "helm_release" "lbc" {
  name       = "load-balancer-controller"
  namespace  = var.namespace
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"

  create_namespace = false

  values = [
    yamlencode({
      clusterName = var.cluster_name
        
      serviceAccount = {
        create = true
        name   = var.sa_name

        annotations = {
          "eks.amazonaws.com/role-arn" = var.irsa_role_arn
        }
      }
      region = "ap-northeast-2"
      vpcId = var.vpc_id
    })
  ]
}
