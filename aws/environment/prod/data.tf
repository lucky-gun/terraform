## Data
locals {
  cluster_name = "lucky-gun-eks"
  eks_version  = "1.33"

  public_access_cidrs = ["116.37.149.145/32"]

  common_tags = {
    Project   = "terraform-eks-study"
    ManagedBy = "Terraform"
  }

}

