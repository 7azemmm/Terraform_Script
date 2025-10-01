resource "aws_security_group" "mysql_sg" {
  vpc_id = var.vpc_id
  name   = "mysql-sg"

  dynamic "ingress" {
    for_each = toset(var.mysql_ingress_cidrs)
    content {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_ami" "this" {
  most_recent = true
  owners      = var.ami_owners

  filter {
    name   = "name"
    values = [var.ami_name_filter]
  }
}

resource "aws_instance" "mysql" {
  ami           = var.ami_id != null ? var.ami_id : data.aws_ami.this.id
  instance_type = var.instance_type
  subnet_id     = var.private_subnet
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.mysql_sg.id]


  tags = merge({
    Name = "mysql-server"
  })
}
