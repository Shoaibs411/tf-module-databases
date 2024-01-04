# Provisioning Document DB Cluster
resource "aws_docdb_cluster" "docdb" {
  cluster_identifier      = "roboshop-${var.ENV}-docdb"
  engine                  = "docdb"
  master_username         = "admin1"
  master_password         = "roboshop1"
#   backup_retention_period = 5                    # Commented to avoid backups in Lab
#   preferred_backup_window = "07:00-09:00"        # Commented to avoid backups in Lab
  skip_final_snapshot     = true
  db_subnet_group_name =  ?
}


# Creates a Subnet-Group
resource "aws_docdb_subnet_group" "default" {
  name       = "roboshop-${var.ENV}-docdb-subnet-group"
  subnet_ids = aws_subnet.private_subnet.*.id

  tags = {
    Name     = "roboshop-${var.ENV}-docdb-subnet-group"
  }
}