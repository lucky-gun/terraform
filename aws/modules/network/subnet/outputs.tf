output "subnet_map" {
  value = {
    for k, s in local.subnet_map :
    k => {
      id = aws_subnet.subnet[k].id
      type = s.type
      az_key = s.az_key
      az_name = s.az_name
    }
  }
}
      
    
