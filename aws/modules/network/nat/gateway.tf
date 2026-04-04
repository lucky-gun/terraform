locals {
  public_subnets = {
    for k, s in var.subnet_map :
    k => s if s.type == "public"
  }

  public_subnets_az = {
    for k, s in local.public_subnets :
    s.az_key => k...
  }

  public_subnet_default_az = {
    for az, keys in local.public_subnets_az :
    az => keys[0]
  }
}

resource "aws_internet_gateway" "main_internet" {
  vpc_id = var.vpc_id

  tags = {
    Name = "main-igw"
  }
}

resource "aws_eip" "nat_eip" {
  for_each = var.az

  domain = "vpc"

  tags = {
    Name = "nat-eip-${each.key}"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  for_each = var.az

  allocation_id = aws_eip.nat_eip[each.key].id
  subnet_id     = var.subnet_map[local.public_subnet_default_az[each.key]].id

  tags = {
    Name = "nat-gateway-${each.key}"
  }

  depends_on = [aws_internet_gateway.main_internet]
}
