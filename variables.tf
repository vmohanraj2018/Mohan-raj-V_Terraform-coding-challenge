variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ec2_ami" {
  description = "AMI ID for Ubuntu Server 20.04 LTS"
  type        = string

  default     = "ami-08c40ec9ead489470"
}

variable "key_pair_name" {
  description = "Name of the existing AWS Key Pair to use for EC2 SSH access"
  type        = string
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t2.micro"
}

variable "db_username" {
  description = "Master username for RDS MySQL"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Master password for RDS MySQL"
  type        = string
  sensitive   = true
}

variable "subnet_ids" {
  description = "List of subnet IDs for RDS DB subnet group"
  type        = list(string)
}
