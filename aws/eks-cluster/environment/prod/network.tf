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
    public = {
      a = { "1" = {} }
      b = { "1" = {} }
    }
    private = {
      a = { "1" = {} }
      b = { "1" = {}, "2" = {} }
    }
    local = {
      a = { "1" = {} }
    }
  }

  eks_config = {
    enabled = true
    cluster_name = local.eks_cluster_name
  } 
}
