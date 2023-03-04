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

