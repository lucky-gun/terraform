output "iam_role_arns" {
  value = {
    for k, v in aws_iam_role.iam_role :
    k => v.arn
  }
}

output "iam_role" {
  value = {
    for k, v in aws_iam_role.iam_role :
    k => v.id
  }
} 
