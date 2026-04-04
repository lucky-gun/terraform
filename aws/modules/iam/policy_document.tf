data "aws_iam_policy_document" "assume_role" {
  for_each = var.iam_roles

  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = each.value.assume_role.type
      identifiers = each.value.assume_role.identifiers
    }
  }
}
