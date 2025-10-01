module "vpc" {
  source = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnets      = var.public_subnets
  private_subnets     = var.private_subnets
  
}

module "wordpress" {
  source         = "./modules/wordpress"
  vpc_id         = module.vpc.vpc_id
  public_subnet  = module.vpc.public_subnet_ids[0]
  key_name       = var.key_name
  instance_type  = var.wp_instance_type
  ami_id         = var.wp_ami_id
  ami_owners     = var.ami_owners
  ami_name_filter = var.wp_ami_name_filter
  asg_min_size   = var.wp_asg_min_size
  asg_max_size   = var.wp_asg_max_size
  asg_desired_capacity = var.wp_asg_desired_capacity
  ingress_rules  = var.wp_ingress_rules
 
}

module "db" {
  source        = "./modules/db"
  vpc_id        = module.vpc.vpc_id
  private_subnet = module.vpc.private_subnet_ids[0]
  key_name      = var.key_name
  instance_type = var.db_instance_type
  ami_id        = var.db_ami_id
  ami_owners    = var.ami_owners
  ami_name_filter = var.db_ami_name_filter
 

}

