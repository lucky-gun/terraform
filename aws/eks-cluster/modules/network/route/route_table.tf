locals {
  public_subnets = {
    for k, s in var.subnet_map :
    k => s if s.type == "public"
  }

  private_subnets = {
    for k, s in var.subnet_map :
    k => s if s.type == "private"
  }

  local_subnets = {
  for k, s in var.subnet_map :
    k => s if s.type == "local"
  }
}


## Public Route Table
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.internet_gateway_id
}

resource "aws_route_table_association" "public" {
  for_each = local.public_subnets

  subnet_id      = var.subnet_map[each.key].id
  route_table_id = aws_route_table.public.id
}



## Private Route Table
resource "aws_route_table" "private" {
  for_each = var.az
  vpc_id = var.vpc_id

  tags = {
    Name = "private-rt-${each.key}"
  }
}

resource "aws_route" "private_nat" {
  for_each = var.az

  route_table_id         = aws_route_table.private[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = var.nat_gateway_ids[each.key]
}

resource "aws_route_table_association" "private" {
  for_each = local.private_subnets

  subnet_id      = var.subnet_map[each.key].id
  route_table_id = aws_route_table.private[var.subnet_map[each.key].az_key].id
}

## Local Route Table
resource "aws_route_table" "local" {
  vpc_id = var.vpc_id

  tags = {
    Name = "local-rt"
  }
}

resource "aws_route_table_association" "local" {
  for_each = local.local_subnets  

  subnet_id      = var.subnet_map[each.key].id
  route_table_id = aws_route_table.local.id
}
