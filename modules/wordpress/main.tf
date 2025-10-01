# WordPress Infrastructure Module 

# Security Group (defined in security_group.tf)
# References: aws_security_group.wordpress_sg

# Launch Template (defined in launch_template.tf)  
# References: aws_launch_template.wordpress_lt, data.aws_ami.this

# Auto Scaling Group (defined in autoscaling.tf)
# References: aws_autoscaling_group.wordpress_asg, aws_autoscaling_policy.scale_out

# The components are loosely coupled through variables and outputs
