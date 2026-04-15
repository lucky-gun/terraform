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
    source_security_group_id = optional(string)
    cidr_blocks              = optional(list(string))
    description              = optional(string,"")
  }))

  validation {
    condition = alltrue([
      for rule in var.security_group_rules :
        (
          rule.source_security_group_key != null ||
          rule.source_security_group_id  != null ||
          rule.cidr_blocks != null
        )
      ])
    error_message = "source_security_group_key or source_security_group_id or cidr_block plz"
  }
  description  = "type = ingress/egress"
}
