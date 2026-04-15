variable "vpc" {
  type = object({
    cidr_block = string
    name       = string
  })

  description  = "VPC CIDR 대역 및 name 확인"
}

variable "az" {
  type = map(string)

  description  = "Avaliable Zone 구역"
}

variable "subnets" {
  type = map(map(map(object({}))))

  description  = "Subnet 구역 (type => az => index)"
}

variable "eks_config" {
  type = object({
    enabled = bool
    cluster_name = string
  })
  default = {
    enabled = false
    cluster_name = null
  }
}
