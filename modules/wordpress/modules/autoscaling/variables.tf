variable "asg_name" { type = string }
variable "asg_min_size" { type = number }
variable "asg_max_size" { type = number }
variable "asg_desired_capacity" { type = number }
variable "asg_tag_name" { type = string }
variable "launch_template_id" { type = string }
variable "launch_template_version" { type = string }
variable "subnet_ids" { type = list(string) }
variable "scaling_policy_name" { type = string }
variable "scaling_adjustment" { type = number }
variable "adjustment_type" { type = string }
variable "cooldown_period" { type = number }
variable "target_group_arn" { type = string }

