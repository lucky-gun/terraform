data "aws_iam_policy_document" "assume_role" {
  for_each = var.irsa

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [var.oidc_provider_arn]
    }

    condition {
      test     = "StringEquals"
      variable = "${var.oidc_provider_url}:sub"

      values = [
        "system:serviceaccount:${each.value.namespace}:${each.value.sa_name}"
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "${var.oidc_provider_url}:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "iam_role" {
  for_each = var.irsa

  name = "${var.cluster_name}-${each.key}-irsa-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role[each.key].json

  tags = each.value.tags
}
