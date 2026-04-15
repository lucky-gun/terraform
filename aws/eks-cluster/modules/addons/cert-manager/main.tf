resource "helm_release" "cm" {
  name       = "cert-manager"
  namespace  = var.namespace
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"

  create_namespace = true

  set = [
    {
      name = "installCRDs"
      value = "true"
    }
  ]
}
