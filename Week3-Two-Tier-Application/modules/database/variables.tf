variable "project_name" { type = string }
variable "environment" { type = string }
variable "subnet_ids" { type = list(string) }
variable "security_group_id" { type = string }
variable "allocated_storage" { type = number; default = 20 }
variable "instance_class" { type = string; default = "db.t4g.micro" }
variable "db_name" { type = string; default = "appdb" }
variable "db_username" { type = string; default = "dbadmin" }
variable "db_password" { type = string; sensitive = true }
variable "tags" { type = map(string); default = {} }
