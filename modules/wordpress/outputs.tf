output "asg_name" {
  value = aws_autoscaling_group.wordpress_asg.name
}

output "wordpress_sg" {
  value = aws_security_group.wordpress_sg.id
}


