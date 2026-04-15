module "vpc" {
  source = "./vpc"
  cidr_block = var.vpc.cidr_block
  vpc_name       = var.vpc.name
}

module "subnet" {
  source = "./subnet"
  vpc_id = module.vpc.vpc_id
  vpc_cidr = var.vpc.cidr_block
  vpc_name = var.vpc.name
  az = var.az
  subnets = var.subnets
  eks_config = var.eks_config
}

module "gateway" {
  source = "./nat"
  vpc_id = module.vpc.vpc_id
  az = var.az
  subnet_map = module.subnet.subnet_map
}

module "route_table" {
  source = "./route"
  vpc_id = module.vpc.vpc_id
  subnet_map = module.subnet.subnet_map
  az = var.az
  internet_gateway_id = module.gateway.main_internet_id
  nat_gateway_ids = module.gateway.nat_gateway_ids
}
