terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.2"
}

provider "aws" {
  region = var.aws_region
}
resource "aws_security_group" "ec2_sg" {
  name        = "ec2_web_sg"
  description = "Allow HTTP (80) and SSH (22) inbound traffic"
  vpc_id      = null

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2_web_sg"
  }
}
resource "aws_security_group" "rds_sg" {
  name        = "rds_mysql_sg"
  description = "Allow MySQL (3306) access from EC2 security group"
  vpc_id      = null

  ingress {
    description          = "MySQL access from EC2"
    from_port            = 3306
    to_port              = 3306
    protocol             = "tcp"
    security_groups      = [aws_security_group.ec2_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds_mysql_sg"
  }
}
resource "aws_instance" "web_server" {
  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type
  key_name      = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y apache2
              systemctl start apache2
              systemctl enable apache2
              echo "<h1>Hello from Terraform-provisioned EC2 web server</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "TerraformWebServer"
  }
}
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds_subnet_group"
  description = "Subnet group for RDS"
  subnet_ids  = var.subnet_ids

  tags = {
    Name = "rds_subnet_group"
  }
}
resource "aws_db_instance" "mysql_db" {
  identifier             = "terraform-mysql-db"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = var.db_instance_class
  allocated_storage      = 20
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot    = true
  publicly_accessible    = false

  tags = {
    Name = "TerraformMySQLDB"
  }
}
