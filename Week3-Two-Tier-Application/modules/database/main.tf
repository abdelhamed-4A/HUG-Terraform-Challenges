resource "aws_db_subnet_group" "this" {
  name        = "${lower(var.project_name)}-${var.environment}-db-subnet-group"
  subnet_ids  = var.subnet_ids
  description = "Private subnet group for RDS database instance"

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-db-subnet-group"
  })
}

resource "aws_db_instance" "this" {
  identifier             = "${lower(var.project_name)}-${var.environment}-db"
  allocated_storage      = var.allocated_storage
  engine                 = "postgres"
  engine_version         = "16.3"
  instance_class         = var.instance_class
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [var.security_group_id]

  publicly_accessible = false
  skip_final_snapshot = true

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-rds"
  })
}
