data "tls_certificate" "eks_ca" {
  url = var.oidc_issuer_url
}

resource "aws_iam_openid_connect_provider" "eks" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks_ca.certificates[0].sha1_fingerprint]
  url             = var.oidc_issuer_url

  tags = var.tags
}
