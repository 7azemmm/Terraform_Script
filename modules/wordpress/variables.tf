variable "vpc_id" {}
variable "public_subnet" {}
variable "key_name" {}
variable "asg_min_size" { default = 1 }
variable "asg_max_size" { default = 3 }
variable "asg_desired_capacity" { default = 1 }
variable "instance_type" { default = "t3.small" }
variable "ami_id" { 
  description = "Specific AMI ID to use. If provided, ami_owners and ami_name_filter will be ignored"
  default = "ami-045f63fff8c39e8dd"
}
variable "ami_owners" { default = ["645537741587"] }
variable "ami_name_filter" { default = "Hazem_Wordpress" }
variable "ingress_rules" {
  type = map(object({ from_port = number, to_port = number, protocol = string, cidr_blocks = list(string) }))
  default = {
    http = { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
    ssh  = { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
  }
}

