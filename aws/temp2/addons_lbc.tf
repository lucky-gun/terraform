resource "helm_release" "lbc" {
  name       = "aws-load-balancer-controller"
  namespace  = "kube-system"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"

  values = [
    yamlencode({
      clusterName = aws_eks_cluster.main.name

      serviceAccount = {
        create = true
        name   = "aws-load-balancer-controller"

        annotations = {
          "eks.amazonaws.com/role-arn" = aws_iam_role.lbc.arn
        }
      }

      region = "ap-northeast-2"
      vpcId  = aws_vpc.main.id
    })
  ]
}
