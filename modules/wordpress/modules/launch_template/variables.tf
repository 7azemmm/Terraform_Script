variable "launch_template_name_prefix" { type = string }
variable "ami_id" { type = string }
variable "ami_owners" { type = list(string) }
variable "ami_name_filter" { type = string }
variable "instance_type" { type = string }
variable "key_name" { type = string }
variable "associate_public_ip" { type = bool }
variable "instance_sg_id" { type = string }
variable "user_data" { type = string }

