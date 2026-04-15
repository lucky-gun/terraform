variable "iam_roles" {
  type = map(object({
    name = string

    assume_role_policy = list(object({
      effect = string
      actions = list(string)

      principals = object({
        type        = string
        identifiers = list(string)
      })
    }))

    policy_arns = optional(list(string), [])
    tags        = optional(map(string))
  }))
}

variable "assume_role_policy" {
  type = map
}
