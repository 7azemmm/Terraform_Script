output "wordpress_asg" {
  value = module.wordpress.asg_name
}
output "asg_name" {
  value = module.wordpress.asg_name
}
output "vpc_id" {
  value = module.vpc.vpc_id
}
output "public_subnet_id" {
  value = module.vpc.public_subnet_id
}
output "private_subnet_id" {
  value = module.vpc.private_subnet_id
}
output "mysql_private_ip" {
  value = module.db.mysql_private_ip
}
