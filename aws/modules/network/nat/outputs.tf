output "main_internet_id" {
  value = aws_internet_gateway.main_internet.id
}

output "nat_gateway_ids" {
  value = {
    for k,gw in aws_nat_gateway.nat_gateway :
    k => gw.id
  }
}
