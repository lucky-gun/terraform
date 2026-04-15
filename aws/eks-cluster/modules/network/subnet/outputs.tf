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
      
output "subnets_id_by_type" {
  value = {
    for type in ["public", "private", "local"] :
    type => [
      for k, v in aws_subnet.subnet :
      v.id if local.subnet_map[k].type == type
    ]
  }
}

output "subnets_id_by_type_per_az" {
  value = {
    for type in ["public", "private", "local"] :
    type => {
      for az in distinct([
        for s in local.subnet_map : s.az_key
      ]) :
      az => [
        for k, v in aws_subnet.subnet :
        v.id
        if local.subnet_map[k].type == type
        && local.subnet_map[k].az_key == az
      ]
    }
  }
}

# 개선 가능성 있음
