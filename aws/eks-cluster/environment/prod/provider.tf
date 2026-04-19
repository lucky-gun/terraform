terraform {
  required_version = ">= 1.5.0"

  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = "ap-northeast-2"
  profile = "terraform-admin"
}

data "aws_eks_cluster_auth" "main" {
  name = local.eks_cluster_name
}

provider "kubernetes" {
  host                   = module.eks.endpoint
  cluster_ca_certificate = base64decode(module.eks.certificate)
  token                  = data.aws_eks_cluster_auth.main.token
}

provider "helm" {
  kubernetes = {
    host                   = module.eks.endpoint
    cluster_ca_certificate = base64decode(module.eks.certificate)
    token                  = data.aws_eks_cluster_auth.main.token
  }
}

provider "cloudflare" {
  api_token = ""
}

module "oidc" {
  source = "../../modules/iam/oidc-provider"
  oidc_issuer_url = module.eks.oidc_issuer_url
  tags = merge(local.common_tags, {
      Name = "${local.eks_cluster_name}-oidc-provider"
  })
  depends_on = [module.eks]
}
