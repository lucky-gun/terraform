resource "helm_release" "ebs_csi" {
  name       = "aws-ebs-csi-driver"
  namespace  = "kube-system"
  repository = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver"
  chart      = "aws-ebs-csi-driver"

  create_namespace = false

  values = [
    yamlencode({
      controller = {
        serviceAccount = {
          create = true
          name   = "ebs-csi-controller-sa"

          annotations = {
            "eks.amazonaws.com/role-arn" = aws_iam_role.ebs_csi.arn
          }
        }
      }
    })
  ]
}

