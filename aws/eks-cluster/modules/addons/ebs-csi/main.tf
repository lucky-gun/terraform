resource "helm_release" "ebs_csi" {
  name       = "aws-ebs-csi-driver"
  namespace  = var.namespace
  repository = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver"
  chart      = "aws-ebs-csi-driver"

  create_namespace = false

  values = [
    yamlencode({
      controller = {
        serviceAccount = {
          create = true
          name   = var.sa_name

          annotations = {
            "eks.amazonaws.com/role-arn" = var.irsa_role_arn
          }
        }
      }
    })
  ]
}
