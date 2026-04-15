output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnets_id_by_type" {
  value = module.subnet.subnets_id_by_type
}

output "subnets_id_by_type_per_az" {
  value = module.subnet.subnets_id_by_type_per_az
}
