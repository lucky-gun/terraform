## Data
locals {
  eks_cluster_name = "lucky-gun-eks"

  common_tags = {
    Project   = "terraform-eks-study"
    ManagedBy = "Terraform"
  }
}

