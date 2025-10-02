data "aws_instances" "wordpress" {
  filter {
    name   = "tag:Name"
    values = [var.asg_tag_name]
  }

  filter {
    name   = "instance-state-name"
    values = ["pending", "running"]
  }
}

data "aws_instance" "wordpress" {
  for_each    = toset(data.aws_instances.wordpress.ids)
  instance_id = each.value
}

