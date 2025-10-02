module "security_group" {
  source              = "./modules/security_group"
  vpc_id              = var.vpc_id
  security_group_name = var.security_group_name
  ingress_rules       = var.ingress_rules
}

module "launch_template" {
  source                      = "./modules/launch_template"
  launch_template_name_prefix = var.launch_template_name_prefix
  ami_id                      = var.ami_id
  ami_owners                  = var.ami_owners
  ami_name_filter             = var.ami_name_filter
  instance_type               = var.instance_type
  key_name                    = var.key_name
  associate_public_ip         = var.associate_public_ip
  instance_sg_id              = module.security_group.id
  user_data                   = local.user_data
}

module "load_balancer" {
  source                  = "./modules/load_balancer"
  vpc_id                  = var.vpc_id
  public_subnet_ids       = var.public_subnet_ids
  alb_name                = var.alb_name
  alb_internal            = var.alb_internal
  alb_ingress_cidrs       = var.alb_ingress_cidrs
  alb_listener_port       = var.alb_listener_port
  alb_listener_protocol   = var.alb_listener_protocol
  target_group_name       = var.target_group_name
  health_check_path       = var.health_check_path
  health_check_matcher    = var.health_check_matcher
}

module "autoscaling" {
  source                   = "./modules/autoscaling"
  asg_name                 = var.asg_name
  asg_min_size             = var.asg_min_size
  asg_max_size             = var.asg_max_size
  asg_desired_capacity     = var.asg_desired_capacity
  asg_tag_name             = var.asg_tag_name
  launch_template_id       = module.launch_template.id
  launch_template_version  = var.launch_template_version
  subnet_ids               = var.public_subnet_ids
  scaling_policy_name      = var.scaling_policy_name
  scaling_adjustment       = var.scaling_adjustment
  adjustment_type          = var.adjustment_type
  cooldown_period          = var.cooldown_period
  target_group_arn         = module.load_balancer.target_group_arn
}
