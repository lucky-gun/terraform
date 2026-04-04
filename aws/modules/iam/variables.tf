variable "iam_roles" {
  type = map(object({
    name = string

    assume_role = object({
      type        = string
      identifiers = list(string)
    })

    policy_arns = list(string)
    inline_policies = optional(map(string))
    tags        = optional(map(string))
  }))
}
