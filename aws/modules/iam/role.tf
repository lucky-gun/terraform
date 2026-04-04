resource "aws_iam_role" "iam_role" {
  for_each = var.iam_roles

  name               = each.value.name
  assume_role_policy = data.aws_iam_policy_document.assume_role[each.key].json

  tags = each.value.tags
}
