variable "project_name" { type = string }
variable "environment" { type = string }
variable "vpc_id" { type = string }
variable "admin_ip" { type = string }
variable "db_port" { type = number; default = 5432 }
variable "tags" { type = map(string); default = {} }
