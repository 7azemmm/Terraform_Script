data "aws_ami" "this" {
  count       = var.ami_id == "" ? 1 : 0
  most_recent = true
  owners      = var.ami_owners

  filter {
    name   = "name"
    values = [var.ami_name_filter]
  }
}

resource "aws_launch_template" "wordpress_lt" {
  name_prefix   = var.launch_template_name_prefix
  image_id      = var.ami_id != "" ? var.ami_id : data.aws_ami.this[0].id
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interfaces {
    associate_public_ip_address = var.associate_public_ip
    security_groups             = [var.instance_sg_id]
  }

  user_data = base64encode(var.user_data)
}

