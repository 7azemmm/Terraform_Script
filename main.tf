module "vpc" {
  source = "./modules/vpc"
}

module "wordpress" {
  source         = "./modules/wordpress"
  vpc_id         = module.vpc.vpc_id
  public_subnet  = module.vpc.public_subnet_id
  key_name       = var.key_name
}

module "db" {
  source        = "./modules/db"
  vpc_id        = module.vpc.vpc_id
  private_subnet = module.vpc.private_subnet_id
  key_name      = var.key_name

}

