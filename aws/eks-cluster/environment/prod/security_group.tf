module "eks_security_group" {
  source = "../../modules/security-group"

  vpc_id = module.main_network.vpc_id
  security_groups = {
    eks_cluster = {
      description = "Security group for EKS control plane"
      tags = merge(local.common_tags, {
        Name = "${local.eks_cluster_name}-cluster-sg"
      })
    }

    eks_node = {
      description = "Security group for EKS worker nodes"
      tags = merge(local.common_tags, {
        Name = "${local.eks_cluster_name}-node-sg"
      })
    }
  }

  security_group_rules = {
    # node → cluster (443)
    eks_cluster_ingress_https_nodes = {
      type                      = "ingress"
      from_port                 = 443
      to_port                   = 443
      protocol                  = "tcp"
      security_group_key        = "eks_cluster"
      source_security_group_key = "eks_node"
      description               = "EKS worker nodes connect to control plane (api server)"
    }

    # cluster → node
    eks_node_ingress_all_cluster = {
      type                      = "ingress"
      from_port                 = 0
      to_port                   = 0
      protocol                  = "-1"
      security_group_key        = "eks_node"
      source_security_group_key = "eks_cluster"
      description               = "EKS control plane connect to worker nodes (ALL)"
    }

    # node self
    eks_node_ingress_self = {
      type                      = "ingress"
      from_port                 = 0
      to_port                   = 0
      protocol                  = "-1"
      security_group_key        = "eks_node"
      source_security_group_key = "eks_node"
      description               = "EKS Node communication"
    }

    # egress rule
    eks_cluster_egress_all = {
      type               = "egress"
      from_port          = 0
      to_port            = 0
      protocol           = "-1"
      security_group_key = "eks_cluster"
      cidr_blocks        = ["0.0.0.0/0"]
      description        = "EKS control plane outbound traffic (ALL)"
    }

    eks_node_egress_all = {
      type               = "egress"
      from_port          = 0
      to_port            = 0
      protocol           = "-1"
      security_group_key = "eks_node"
      cidr_blocks        = ["0.0.0.0/0"]
      description        = "EKS worker nodes outbound traffic (ALL)"
    }
  }
}

module "rds_security_group" {
  source = "../../modules/security-group"

  vpc_id = module.main_network.vpc_id
  security_groups = {
    rds = {
      description = "Security group for RDS"
      tags = merge(local.common_tags, {
        Name = "${local.eks_cluster_name}-rds-sg"
      })
    }
  }

  security_group_rules = {
    rds_ingress_all = {
      type                      = "ingress"
      from_port                 = 3306
      to_port                   = 3306
      protocol                  = "tcp"
      security_group_key        = "rds"
      cidr_blocks 		= ["10.0.0.0/16"]
      description               = "EKS nodes connect to RDS"
    }

    rds_egress_all = {
      type                      = "egress"
      from_port                 = 0
      to_port                   = 0
      protocol                  = "-1"
      security_group_key        = "rds"
      cidr_blocks               = ["0.0.0.0/0"]
      description               = "RDS outbound traffic (ALL)"
    }
  }
}
