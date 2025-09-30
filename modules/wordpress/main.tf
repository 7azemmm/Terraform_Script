variable "vpc_id" {}
variable "public_subnet" {}
variable "key_name" {}

# Security Group
resource "aws_security_group" "wordpress_sg" {
  vpc_id = var.vpc_id
  name   = "wordpress-sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Launch Template
resource "aws_launch_template" "wordpress_lt" {
  name_prefix   = "Hazem-wordpress-"
  image_id      = "ami-045f63fff8c39e8dd" # Your custom WordPress AMI
  instance_type = "t3.small"
  key_name      = var.key_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.wordpress_sg.id]
  }

  user_data = base64encode(<<-EOF
  #!/bin/bash
  systemctl enable apache2
  systemctl restart apache2
EOF
  )
}

# Auto Scaling Group
resource "aws_autoscaling_group" "wordpress_asg" {
  desired_capacity    = 1
  max_size            = 3
  min_size            = 1
  vpc_zone_identifier = [var.public_subnet]

  launch_template {
    id      = aws_launch_template.wordpress_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "wordpress-asg"
    propagate_at_launch = true
  }
}

# Simple Scaling Policy: Scale out when CPU > 50%
resource "aws_autoscaling_policy" "scale_out" {
  name                   = "scale-out"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.wordpress_asg.name
}

# Outputs
output "asg_name" {
  value = aws_autoscaling_group.wordpress_asg.name
}

output "wordpress_sg" {
  value = aws_security_group.wordpress_sg.id
}
