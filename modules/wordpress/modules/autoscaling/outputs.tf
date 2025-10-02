output "asg_name" { value = aws_autoscaling_group.this.name }
output "asg_arn" { value = aws_autoscaling_group.this.arn }
output "scaling_policy_arn" { value = aws_autoscaling_policy.scale_out.arn }

