output "irsa_role_arns" {
  value = {
    for k, v in aws_iam_role.iam_role :
    k => v.arn
  }
}
