terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

resource "aws_db_instance" "rds_mysql" {
    identifier = "rds-mysql-${var.cluster_name}-${random_string.random.result}"
    allocated_storage = 20
    engine = var.replicate_source_db == null ? "mysql" : null
    instance_class = "db.t3.micro"
    skip_final_snapshot = true
    db_name = var.replicate_source_db == null ? var.db_name : null
    apply_immediately = true
    db_subnet_group_name = var.subnet_group_name
    vpc_security_group_ids = [aws_security_group.rds_sg.id]

    backup_retention_period = var.backup_retention_period

    replicate_source_db = var.replicate_source_db

    username = var.replicate_source_db == null ? var.rds_username : null
    password = var.replicate_source_db == null ? var.rds_password : null

}


# Generate random string without any special characters, all lowercase
resource "random_string" "random" {
    length = 4
    special = false
    upper = false
}

#************************************************************#
# RDS Security Group                                         # 
#************************************************************#
resource "aws_security_group" "rds_sg" {
    name = "${var.cluster_name}-rds-sg"
    description = "Allow traffic only from ASG EC2 instances"
    vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "rds_sg_rule_ingress" {
    type = "ingress"
    description = "Allow traffic only from ASG EC2 instances"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    source_security_group_id = var.security_group_id
    security_group_id = aws_security_group.rds_sg.id
}

resource "aws_security_group_rule" "rds_sg_rule_egress" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.rds_sg.id
}

