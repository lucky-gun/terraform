resource "aws_security_group_rule" "sg_rule" {
  for_each = var.security_group_rules

  type              = each.value.type
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol

  security_group_id = aws_security_group.sg[each.value.security_group_key].id

  source_security_group_id = each.value.type == "ingress" ? (
    try(each.value.source_security_group_id, null) != null ? each.value.source_security_group_id :
    try(each.value.source_security_group_key, null) != null ? aws_security_group.sg[each.value.source_security_group_key].id :
    null
  ) : null

  cidr_blocks = try(each.value.cidr_blocks, null)

  description = each.value.description
}
