module "rds" {
  source = "../../modules/rds"
  subnet_ids = module.main_network.subnets_id_by_type["private"]
  security_group_ids = [module.rds_security_group.security_groups["rds"].id] 
  identifier = "wordpress-db"
  engine    = "mysql"
  instance_class = "db.t3.micro"
  allocated_storage = 20
  db_name = "wordpress"
  username = "wpadmin"
  password = "wppassword123"
  depends_on = [
    module.main_network
  ]
}
