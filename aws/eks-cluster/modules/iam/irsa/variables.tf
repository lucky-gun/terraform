variable "cluster_name" {
  type = string
}

variable "oidc_provider_arn" {
  type = string
}

variable "oidc_provider_url" {
  type = string
}

variable "irsa" {
  type = map(object({
    namespace = string
    sa_name   = string

    policy_arns = optional(list(string), [])

    policy_json = optional(string)

    tags = optional(map(string), {})
  }))
  default = {}
}
