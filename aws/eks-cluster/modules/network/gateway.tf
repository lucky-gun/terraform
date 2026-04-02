resource "aws_internet_gateway" "main" {
  vpc_id = var.vpc_id

  tags = {
    Name = "main-igw"
  }
}

resource "aws_eip" "nat_eip" {
  for_each = var.azs

  domain = "vpc"

  tags = {
    Name = "nat-eip-${each.key}"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  for_each = var.azs

  allocation_id = aws_eip.nat_eip[each.key].id
  subnet_id     = each.value.public_subnet_id

  tags = {
    Name = "nat-gateway-${each.key}"
  }

  depends_on = [aws_internet_gateway.main]
}
