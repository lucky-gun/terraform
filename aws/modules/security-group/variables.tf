variable "vpc_id" {
  type = string
}

variable "security_groups" {
  type = map(object({
    description = string
    tags        = map(string)
  }))
}

variable "security_group_rules" {
  type = map(object({
    type                     = string
    from_port                = number
    to_port                  = number
    protocol                 = string
    security_group_key       = string
    source_security_group_key = optional(string)
    cidr_blocks              = optional(list(string))
    description              = string
  }))

  description  = "type = ingress/egress"
}
