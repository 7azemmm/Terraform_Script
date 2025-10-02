# Auto Scaling Group Outputs
output "asg_name" { value = module.autoscaling.asg_name }
output "asg_arn" { value = module.autoscaling.asg_arn }

# Security Group Outputs
output "wordpress_sg" { value = module.security_group.id }
output "security_group_arn" { value = module.security_group.arn }

# Launch Template Outputs
output "launch_template_id" { value = module.launch_template.id }
output "launch_template_arn" { value = module.launch_template.arn }

# Scaling Policy Outputs
output "scaling_policy_arn" { value = module.autoscaling.scaling_policy_arn }

# AMI Output
output "ami_id_used" { value = var.ami_id }

output "alb_arn" { value = module.load_balancer.alb_arn }
output "alb_dns_name" { value = module.load_balancer.alb_dns_name }
output "alb_sg_id" { value = module.load_balancer.alb_sg_id }
output "target_group_arn" { value = module.load_balancer.target_group_arn }

# output "wordpress_instance_public_ips" {
#   description = "Public IPs of WordPress instances discovered by Name tag"
#   value       = [for i in data.aws_instance.wordpress : i.public_ip]
# }