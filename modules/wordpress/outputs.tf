# Auto Scaling Group Outputs
output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.wordpress_asg.name
}

output "asg_arn" {
  description = "ARN of the Auto Scaling Group"
  value       = aws_autoscaling_group.wordpress_asg.arn
}

# Security Group Outputs
output "wordpress_sg" {
  description = "ID of the WordPress security group"
  value       = aws_security_group.wordpress_sg.id
}

output "security_group_arn" {
  description = "ARN of the security group"
  value       = aws_security_group.wordpress_sg.arn
}

# Launch Template Outputs
output "launch_template_id" {
  description = "ID of the launch template"
  value       = aws_launch_template.wordpress_lt.id
}

output "launch_template_arn" {
  description = "ARN of the launch template"
  value       = aws_launch_template.wordpress_lt.arn
}

# Scaling Policy Outputs
output "scaling_policy_arn" {
  description = "ARN of the scaling policy"
  value       = aws_autoscaling_policy.scale_out.arn
}

# AMI Output
output "ami_id_used" {
  description = "ID of the AMI used"
  value       = var.ami_id != null ? var.ami_id : data.aws_ami.this.id
}


