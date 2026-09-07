variable "project_name" { type = string }
variable "environment" { type = string }
variable "vpc_cidr" { type = string; default = "10.30.0.0/16" }
variable "enable_dns_support" { type = bool; default = true }
variable "enable_dns_hostnames" { type = bool; default = true }
variable "tags" { type = map(string); default = {} }
