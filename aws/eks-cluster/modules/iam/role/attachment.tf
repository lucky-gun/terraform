locals {
  policy_map = flatten([
    for role_key, role in var.iam_roles : [
      for policy_arn in role.policy_arns : {
        role_key   = role_key
        policy_arn = policy_arn
      }
    ]
  ])
}

resource "aws_iam_role_policy_attachment" "policy_attach" {
  for_each = {
    for idx, v in local.policy_map :
    "${v.role_key}-${idx}" => v
  }

  role       = aws_iam_role.iam_role[each.value.role_key].name
  policy_arn = each.value.policy_arn
}

