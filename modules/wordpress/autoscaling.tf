# Auto Scaling Group for WordPress instances
resource "aws_autoscaling_group" "wordpress_asg" {
  name                = var.asg_name
  desired_capacity    = var.asg_desired_capacity
  max_size            = var.asg_max_size
  min_size            = var.asg_min_size
  vpc_zone_identifier = [var.public_subnet]

  launch_template {
    id      = aws_launch_template.wordpress_lt.id
    version = var.launch_template_version
  }

  tag {
    key                 = "Name"
    value               = var.asg_tag_name
    propagate_at_launch = true
  }
}

# Auto Scaling Policy
resource "aws_autoscaling_policy" "scale_out" {
  name                   = var.scaling_policy_name
  scaling_adjustment     = var.scaling_adjustment
  adjustment_type        = var.adjustment_type
  cooldown               = var.cooldown_period
  autoscaling_group_name = aws_autoscaling_group.wordpress_asg.name
}