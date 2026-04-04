resource "aws_iam_policy" "custom" {
  for_each = merge([
    for role_key, role in var.iam_roles : {
      for policy_name, policy_json in try(role.inline_policies, {}) :
      "${role_key}-${policy_name}" => {
        role_key   = role_key
        policy_json = policy_json
      }
    }
  ]...)

  name   = each.key
  policy = each.value.policy_json
}
