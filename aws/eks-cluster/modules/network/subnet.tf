locals {
  subnet_keys = keys(var.subnets)

  subnet_map = {
    for idx, key in local.subnet_keys :
    key => merge(var.subnets[key], {
      cidr_block = cidrsubnet(var.vpc.cidr_block, 8, idx)
      az_name = var.az[var.subnets[key].az]
    })
  }
}

resource "aws_subnet" "subnet" {
  for_each = local.subnet_map

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.az_name

  map_public_ip_on_launch = each.value.type == "public"

  tags = {
    Name = "${var.vpc.name}-${each.key}"
    Type = each.value.type

    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"

    # public / private 분기
    "kubernetes.io/role/elb" = each.value.type == "public" ? "1" : null
    "kubernetes.io/role/internal-elb" = each.value.type == "private" ? "1" : null
  }
}
