output "assume_role_policy" {
  value = {
    for k, v in data.aws_iam_policy_document.assume_role :
    k => v
  }
}
