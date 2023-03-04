output "address" {
  description = "The address of the RDS instance"  
  value = aws_db_instance.rds_mysql.address
}

output port {
  description = "The port on which the DB accepts connections"  
  value = aws_db_instance.rds_mysql.port
}

output "arn" {
  description = "The ARN of the RDS instance"  
  value = aws_db_instance.rds_mysql.arn
}