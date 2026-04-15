locals {
  policy_attachments = flatten([
    for key, val in var.irsa : [
      for arn in val.policy_arns : {
        key        = key
        policy_arn = arn
      }
    ]
  ])
}

resource "aws_iam_role_policy_attachment" "policy_attach" {
  for_each = {
    for idx, val in local.policy_attachments :
    "${val.key}-${idx}" => val
  }

  role       = aws_iam_role.iam_role[each.value.key].name
  policy_arn = each.value.policy_arn
}

resource "aws_iam_role_policy_attachment" "custom_policy_attach" {
  for_each = aws_iam_policy.policy

  role       = aws_iam_role.iam_role[each.key].name
  policy_arn = each.value.arn
}
