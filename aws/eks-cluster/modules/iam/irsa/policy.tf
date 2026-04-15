resource "aws_iam_policy" "policy" {
  for_each = {
    for k, v in var.irsa :
    k => v if try(v.policy_json, null) != null
  }

  name   = "${var.cluster_name}-${each.key}-policy"
  policy = each.value.policy_json
}


