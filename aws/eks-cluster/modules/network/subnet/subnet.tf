locals {
  subnet_types = ["public", "private", "local"]

  subnet_formula = flatten([
    for type_idx, type in local.subnet_types : [
      for az_idx, az_key in sort(keys(var.subnets[type])) : [
        for subnet_idx, _ in var.subnets[type][az_key] : {
          key = "${type}-${az_key}-${subnet_idx}"
          type  = type
          az_key  = az_key
          az_name  = var.az[az_key]

          cidr_block = cidrsubnet(var.vpc_cidr, 8, type_idx * 20 + az_idx * 5 + tonumber(subnet_idx))
         }
      ]
    ]
  ])

  subnet_map = {
    for s in local.subnet_formula :
    s.key => s
  }
}

resource "aws_subnet" "subnet" {
  for_each = local.subnet_map

  vpc_id            = var.vpc_id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.az_name

  map_public_ip_on_launch = each.value.type == "public"

  tags = merge(
    {
      Name = "${var.vpc_name}-${each.key}-subnet"
      Type = each.value.type
    },
    var.eks_config.enabled ? {
      "kubernetes.io/cluster/${var.eks_config.cluster_name}" = "shared"
    } : {},
    each.value.type == "public" && var.eks_config.enabled ? {
      "kubernetes.io/role/elb" = "1"
    } : {},
    each.value.type == "private" && var.eks_config.enabled ? {
      "kubernetes.io/role/internal-elb" = "1"
    } : {}
  )
}
