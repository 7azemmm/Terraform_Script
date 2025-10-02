variable "vpc_id" { type = string }
variable "public_subnet_ids" { type = list(string) }
variable "alb_name" { type = string }
variable "alb_internal" { type = bool }
variable "alb_ingress_cidrs" { type = list(string) }
variable "alb_listener_port" { type = number }
variable "alb_listener_protocol" { type = string }
variable "target_group_name" { type = string }
variable "health_check_path" { type = string }
variable "health_check_matcher" { type = string }

