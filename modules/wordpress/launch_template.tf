data "aws_ami" "this" {
  most_recent = true
  owners      = var.ami_owners

  filter {
    name   = "name"
    values = [var.ami_name_filter]
  }
}

resource "aws_launch_template" "wordpress_lt" {
  name_prefix   = var.launch_template_name_prefix
  image_id      = var.ami_id != null ? var.ami_id : data.aws_ami.this.id
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interfaces {
    associate_public_ip_address = var.associate_public_ip
    security_groups             = [aws_security_group.wordpress_sg.id]
  }

  user_data = base64encode(local.user_data)
}