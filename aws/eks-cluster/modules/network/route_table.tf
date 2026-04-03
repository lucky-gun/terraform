locals {
  public_subnets = {
    for k, v in var.subnets :
    k => v if v.type == "public"
  }

  private_subnets = {
    for k, v in var.subnets :
    k => v if v.type == "private"
  }

  private_subnets_by_az = {
    for az_key in keys(var.az) :
    az_key => [
      for k, v in var.subnets :
      k if v.az == az_key && v.type == "private"
    ]
  }
}

## Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main_internet.id
}

resource "aws_route_table_association" "public" {
  for_each = local.public_subnets

  subnet_id      = aws_subnet.subnet[each.key].id
  route_table_id = aws_route_table.public.id
}



## Private Route Table
resource "aws_route_table" "private" {
  for_each = var.az

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "private-rt-${each.key}"
  }
}

resource "aws_route" "private_nat" {
  for_each = var.az

  route_table_id         = aws_route_table.private[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway[each.key].id
}

resource "aws_route_table_association" "private" {
  for_each = merge([
    for az_key, subnet_list in local.private_subnets_by_az : {
      for subnet_key in subnet_list :
      subnet_key => {
        az = az_key
      }
    }
  ]...)
  subnet_id      = aws_subnet.subnet[each.key].id
  route_table_id = aws_route_table.private[each.value.az].id
}
