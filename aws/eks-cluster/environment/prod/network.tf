data "aws_availability_zones" "available" {
  state = "available"
}

module "main_network" {
  source = "../../modules/network"

  vpc = {
    cidr_block  = "10.0.0.0/16"
    name        = "lucky-gun"
  }

  az = {
    a = data.aws_availability_zones.available.names[0],
    b = data.aws_availability_zones.available.names[1]
  }

  subnets = {
    a-public-1 = { az = "a", type = "public" }
    a-private-1 = { az = "a", type = "private" }
    b-public-1 = { az = "b", type = "public" }
    b-private-1 = { az = "b", type = "private" }
  }

  eks = local.cluster_name
}
