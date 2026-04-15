resource "helm_release" "haproxy" {
  name       = "haproxy-ingress"
  namespace  = var.namespace
  repository = "https://haproxy-ingress.github.io/charts"
  chart      = "haproxy-ingress"

  create_namespace = true

  values = var.values
}
