variable "vpc_id" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "az" {
  type = map(string)
}

variable "subnets" {
  type = map(map(map(object({}))))
}

variable "eks_config" {
  type = object({
    enabled = bool
    cluster_name = string
  })
}
