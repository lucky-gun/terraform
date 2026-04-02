resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.vpc_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "public" {
  for_each = var.azs

  subnet_id      = each.value.public_subnet_id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  for_each = var.azs

  vpc_id = var.vpc_id

  tags = {
    Name = "private-rt-${each.key}"
  }
}

resource "aws_route" "private_nat" {
  for_each = var.azs

  route_table_id         = aws_route_table.private[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway[each.key].id
}

resource "aws_route_table_association" "private" {
  for_each = var.azs

  subnet_id      = each.value.private_subnet_id
  route_table_id = aws_route_table.private[each.key].id
}
