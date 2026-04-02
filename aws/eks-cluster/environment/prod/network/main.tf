module "network" {
  source = "../../../modules/network"

  name = "lucky-gun"
  cidr = "10.0.0.0/16"
}

