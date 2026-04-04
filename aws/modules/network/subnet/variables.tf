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
