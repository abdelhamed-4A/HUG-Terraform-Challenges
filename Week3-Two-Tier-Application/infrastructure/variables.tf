variable "aws_region" { type = string; default = "us-east-1" }
variable "project_name" { type = string; default = "HUG-Terraform-Challenge" }
variable "environment" { type = string; default = "dev" }
variable "vpc_cidr" { type = string; default = "10.30.0.0/16" }
variable "availability_zones" { type = list(string); default = ["us-east-1a", "us-east-1b"] }
variable "public_subnet_cidr" { type = string; default = "10.30.1.0/24" }
variable "private_subnet_cidrs" { type = list(string); default = ["10.30.11.0/24", "10.30.12.0/24"] }
variable "admin_ip" { type = string }
variable "instance_type" { type = string; default = "t2.micro" }
variable "key_name" { type = string; default = "" }
variable "full_name" { type = string; default = "Abdel-Hamed Abdel-Nasser" }
variable "db_allocated_storage" { type = number; default = 20 }
variable "db_instance_class" { type = string; default = "db.t4g.micro" }
variable "db_username" { type = string; default = "dbadmin" }
variable "db_password" { type = string; sensitive = true }
variable "tags" { type = map(string); default = {} }
