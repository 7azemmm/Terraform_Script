variable "vpc_id" {}
variable "private_subnet" {}
variable "key_name" {}
variable "instance_type" { default = "t3.micro" }
variable "ami_id" { 
  description = "Specific AMI ID to use. If provided, ami_owners and ami_name_filter will be ignored"
  default = "ami-0c983657c8acbf959" 
}
variable "ami_owners" { default = ["self", "amazon"] }
variable "ami_name_filter" { default = "*ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*" }
variable "mysql_ingress_cidrs" { 
  type = list(string) 
  default = ["0.0.0.0/0"] 
}

