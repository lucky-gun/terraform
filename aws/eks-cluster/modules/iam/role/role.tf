resource "aws_iam_role" "iam_role" {
  for_each = var.iam_roles

  name               = each.value.name
  assume_role_policy = var.assume_role_policy[each.key].json

  tags = each.value.tags
}
