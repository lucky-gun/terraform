data "aws_iam_policy_document" "assume_role" {
  for_each = var.iam_roles

  dynamic "statement" {
    for_each = each.value.assume_role_policy

    content {
      effect  = statement.value.effect
      actions = statement.value.actions

      principals {
        type        = statement.value.principals.type
        identifiers = statement.value.principals.identifiers
      }

      dynamic "condition" {
        for_each = statement.value.conditions

        content {
          test     = condition.value.test
          variable = condition.value.variable
          values   = condition.value.values
        }
      }
    }
  }
}
