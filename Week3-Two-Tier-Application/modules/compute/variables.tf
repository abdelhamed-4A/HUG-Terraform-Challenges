variable "project_name" { type = string }
variable "environment" { type = string }
variable "subnet_id" { type = string }
variable "security_group_id" { type = string }
variable "instance_type" { type = string; default = "t2.micro" }
variable "key_name" { type = string; default = "" }
variable "full_name" { type = string; default = "Abdel-Hamed Abdel-Nasser" }
variable "db_endpoint" { type = string; default = "Initializing..." }
variable "tags" { type = map(string); default = {} }
