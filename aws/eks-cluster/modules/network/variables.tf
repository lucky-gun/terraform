variable "vpc" {
  type = object({
    cidr_block = string
    name       = string
  })

  description  = "VPC CIDR 대역 및 name 확인"
}

variable "eks_cluster_name" {
  type = string
}

variable "az" {
  type = map(string)
}

variable "subnets" {
  type = map(object({
    az   = string
    type = string
  }))
}
