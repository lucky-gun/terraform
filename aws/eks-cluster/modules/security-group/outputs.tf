output "security_groups" {
  value = {
    for k, sg in aws_security_group.sg :
    k => {
      id   = sg.id
      arn  = sg.arn
      name = sg.name
    }
  }
}
