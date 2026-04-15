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

      conditions = optional(map(object({
        test = string
        variable = string
        values = list(string)
      })), {})
    }))

    policy_arns = optional(list(string), [])
    inline_policies = optional(map(string), {})
    tags        = optional(map(string))
  }))
}
