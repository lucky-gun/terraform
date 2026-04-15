module "policy" {
  source = "./policy"
  iam_roles = var.iam_roles
   
}

module "role" {
  source = "./role"
  iam_roles = var.iam_roles
  assume_role_policy = module.policy.assume_role_policy
}
