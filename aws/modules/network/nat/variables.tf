variable "vpc_id" {
  type = string
}

variable "az" {
  type = map(string)
}

variable "subnet_map" {
  type = map(object({
    id      = string
    type    = string
    az_key  = string
    az_name = string
  }))
}
