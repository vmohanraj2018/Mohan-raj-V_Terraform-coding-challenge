output "ec2_public_ip" {
  description = "Public IP address of EC2 web server"
  value       = aws_instance.web_server.public_ip
}

output "ec2_public_dns" {
  description = "Public DNS of EC2 web server"
  value       = aws_instance.web_server.public_dns
}

output "rds_endpoint" {
  description = "Endpoint of the RDS MySQL instance"
  value       = aws_db_instance.mysql_db.endpoint
}

output "rds_username" {
  description = "Master username for RDS MySQL"
  value       = aws_db_instance.mysql_db.username
}
