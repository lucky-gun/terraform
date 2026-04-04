locals {
  public_subnets_by_az = {
    for az_key in keys(var.az) :
    az_key => [
      for k, v in var.subnets :
      k if v.az == az_key && v.type == "public"
    ]
  }
}

resource "aws_internet_gateway" "main_internet" {
  vpc_id = aws_vpc.main.id

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
  subnet_id     = aws_subnet.subnet[one(local.public_subnets_by_az[each.key])].id

  tags = {
    Name = "nat-gateway-${each.key}"
  }

  depends_on = [aws_internet_gateway.main_internet]
}
