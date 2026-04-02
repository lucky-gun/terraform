variable "vpc" {
  type = object({
    cidr_block = string
    name       = string
  })

  description  = "VPC CIDR 대역 및 name 확인"
}

variable "public_subnets" {
  type = list(object({
    cidr_block = string
    az_index   = number
  }))

  description  = "Public Subnet 대역"
}

variable "private_subnets" {
  type = list(object({
    cidr_block = string
    az_index   = number
  }))

  description  = "Private Subnet 대역"
}
