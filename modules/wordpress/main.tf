# Security Group
resource "aws_security_group" "wordpress_sg" {
  vpc_id = var.vpc_id
  name   = "wordpress-sg"

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Launch Template
data "aws_ami" "this" {
  most_recent = true
  owners      = var.ami_owners

  filter {
    name   = "name"
    values = [var.ami_name_filter]
  }
}

resource "aws_launch_template" "wordpress_lt" {
  name_prefix   = "wordpress-"
  image_id      = var.ami_id != null ? var.ami_id : data.aws_ami.this.id
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.wordpress_sg.id]
  }

  user_data = base64encode(<<-EOF
  #!/bin/bash
  set -euo pipefail
  if command -v systemctl >/dev/null 2>&1; then
    systemctl enable apache2 || true
    systemctl restart apache2 || true
  fi
EOF
  )
}

# Auto Scaling Group
resource "aws_autoscaling_group" "wordpress_asg" {
  desired_capacity    = var.asg_desired_capacity
  max_size            = var.asg_max_size
  min_size            = var.asg_min_size
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


resource "aws_autoscaling_policy" "scale_out" {
  name                   = "scale-out"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.wordpress_asg.name
}

 
