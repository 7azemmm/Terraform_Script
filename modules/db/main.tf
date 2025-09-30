variable "vpc_id" {}
variable "private_subnet" {}
variable "key_name" {}

resource "aws_security_group" "mysql_sg" {
  vpc_id = var.vpc_id
  name   = "mysql-sg"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # for testing (replace with WP subnet CIDR later)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "mysql" {
  ami           = "ami-0c983657c8acbf959" # my ready sql instance AMI
  instance_type = "t3.micro"
  subnet_id     = var.private_subnet
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.mysql_sg.id]


  tags = {
    Name = "mysql-server"
  }
}

output "mysql_private_ip" {
  value = aws_instance.mysql.private_ip
}
