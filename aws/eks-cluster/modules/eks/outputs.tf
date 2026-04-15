output "oidc_issuer_url" {
  value = aws_eks_cluster.main.identity[0].oidc[0].issuer
}

output "endpoint" {
  value = aws_eks_cluster.main.endpoint
}

output "certificate" {
  value = aws_eks_cluster.main.certificate_authority[0].data
}
