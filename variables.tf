variable "rds_username" {
    description = "The username for the RDS instance"
    type = string
    sensitive = true
    default = null
}

variable "rds_password" {
    description = "The password for the RDS instance"
    type = string
    sensitive = true
    default = null
}

variable "db_name" {
    description = "The name of the database to create when the DB instance is created"
    type = string
    default = null
}

variable "rds_suffix" {
    description = "Suffix to append to the RDS instance name"
    type        = string
}

variable "cluster_name" {
    description = "Name of the cluster"
    type        = string
}

variable "subnet_ids" {
    description = "Subnet IDs to use for the RDS instance"
    type = list(string)
}

variable "deploy_rds" {
    description = "Whether to deploy the RDS instance or not"
    type = bool
    default = true
}

variable "backup_retention_period" {
    description = "The days to retain backups for. Must be > 0 to enable replication."
    type = number
    default = null
}

variable "replicate_source_db" {
    description = "The ARN of the source DB instance or DB snapshot if this DB instance is to be created as a Read Replica."
    type = string
    default = null
}