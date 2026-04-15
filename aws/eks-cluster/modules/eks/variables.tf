variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "cluster_role_arn" {
  type = string
}

variable "node_role_arn" {
  type = string
}

variable "vpc_config" {
  type = object({
    subnet_ids              = list(string)
    security_group_ids      = list(string)
    endpoint_private_access = optional(bool, true)
    endpoint_public_access  = optional(bool, true)
    public_access_cidrs     = optional(list(string), ["0.0.0.0/0"])
  })
}

variable "enabled_cluster_log_types" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}
