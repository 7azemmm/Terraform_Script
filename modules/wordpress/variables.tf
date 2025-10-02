# Network Configuration
variable "vpc_id" {
  description = "VPC ID where resources will be created"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for the ALB"
  type        = list(string)
}

variable "public_subnet" {
  description = "Public subnet ID for instances"
  type        = string
}

# Security Group Variables
variable "security_group_name" {
  description = "Name for the security group"
  type        = string
  default     = "wordpress-sg"
}

variable "ingress_rules" {
  description = "Map of ingress rules for security group"
  type = map(object({ 
    from_port = number, 
    to_port = number, 
    protocol = string, 
    cidr_blocks = list(string) 
  }))
  default = {
    http = { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
    ssh  = { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
  }
}

# Launch Template Variables
variable "launch_template_name_prefix" {
  description = "Name prefix for launch template"
  type        = string
  default     = "wordpress-"
}

variable "key_name" {
  description = "AWS key pair name"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.small"
}

variable "ami_id" {
  description = "Specific AMI ID to use. If provided, ami_owners and ami_name_filter will be ignored"
  type        = string
  default     = "ami-045f63fff8c39e8dd"
}

variable "ami_owners" {
  description = "List of AMI owners to search"
  type        = list(string)
  default     = ["645537741587"]
}

variable "ami_name_filter" {
  description = "Name filter for AMI search"
  type        = string
  default     = "Hazem_Wordpress"
}

variable "associate_public_ip" {
  description = "Whether to associate public IP"
  type        = bool
  default     = true
}

variable "custom_user_data" {
  description = "Custom user data script (optional)"
  type        = string
  default     = ""
}

# Auto Scaling Group Variables
variable "asg_name" {
  description = "Name for the Auto Scaling Group"
  type        = string
  default     = "wordpress-asg"
}

variable "asg_min_size" {
  description = "Minimum size of ASG"
  type        = number
  default     = 2
}

variable "asg_max_size" {
  description = "Maximum size of ASG"
  type        = number
  default     = 3
}

variable "asg_desired_capacity" {
  description = "Desired capacity of ASG"
  type        = number
  default     = 2
}

variable "asg_tag_name" {
  description = "Name tag for ASG instances"
  type        = string
  default     = "wordpress-asg"
}

variable "launch_template_version" {
  description = "Launch template version to use"
  type        = string
  default     = "$Latest"
}

# Scaling Policy Variables
variable "scaling_policy_name" {
  description = "Name for scaling policy"
  type        = string
  default     = "scale-out"
}

variable "scaling_adjustment" {
  description = "Number of instances to add/remove"
  type        = number
  default     = 1
}

variable "adjustment_type" {
  description = "Type of adjustment (ChangeInCapacity, etc.)"
  type        = string
  default     = "ChangeInCapacity"
}

variable "cooldown_period" {
  description = "Cooldown period in seconds"
  type        = number
  default     = 300
}


# Load Balancer variables
variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
  default     = "wordpress-alb"
}

variable "alb_internal" {
  description = "Whether the ALB is internal"
  type        = bool
  default     = false
}


variable "alb_ingress_cidrs" {
  description = "CIDR blocks allowed to access the ALB listener"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "alb_listener_port" {
  description = "Listener port for ALB"
  type        = number
  default     = 80
}

variable "alb_listener_protocol" {
  description = "Listener protocol for ALB"
  type        = string
  default     = "HTTP"
}

variable "target_group_name" {
  description = "Name of the target group"
  type        = string
  default     = "wordpress-tg"
}

variable "health_check_path" {
  description = "Health check path for target group"
  type        = string
  default     = "/"
}

variable "health_check_matcher" {
  description = "HTTP codes to match for healthy checks"
  type        = string
  default     = "200-399"
}
