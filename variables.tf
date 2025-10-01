variable "region" {
  default = "us-east-1"
}

variable "key_name" {
  description = "EC2 key pair for SSH"
  default     = "HazemKeyEc2Task"
}



# Networking
variable "vpc_cidr" { default = "10.0.0.0/16" }
variable "public_subnets" {
  type = map(string)
  default = {
    "us-east-1a" = "10.0.1.0/24"
  }
}
variable "private_subnets" {
  type = map(string)
  default = {
    "us-east-1b" = "10.0.2.0/24"
  }
}

# AMI lookup shared
variable "ami_owners" { default = ["645537741587", "self", "amazon"] }

# WordPress parameters
variable "wp_instance_type" { default = "t3.small" }
variable "wp_ami_id" { 
  description = "Specific AMI ID for WordPress instance. If provided, will override ami_name_filter"
  default = "ami-045f63fff8c39e8dd" 
}
variable "wp_ami_name_filter" { default = "Hazem_Wordpress" }
variable "wp_asg_min_size" { default = 1 }
variable "wp_asg_max_size" { default = 3 }
variable "wp_asg_desired_capacity" { default = 1 }
variable "wp_ingress_rules" {
  type = map(object({ from_port = number, to_port = number, protocol = string, cidr_blocks = list(string) }))
  default = {
    http = { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
    ssh  = { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
  }
}

# DB parameters
variable "db_instance_type" { default = "t3.micro" }
variable "db_ami_id" { 
  description = "Specific AMI ID for database instance. If provided, will override ami_name_filter"
  default = "ami-0c983657c8acbf959"
}
variable "db_ami_name_filter" { default = "*ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*" }