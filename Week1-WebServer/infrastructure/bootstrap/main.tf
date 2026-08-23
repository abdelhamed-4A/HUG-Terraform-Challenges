/**
  * Main Terraform Configuration
  * This configuration sets up the foundational infrastructure for the project, including a VPC, security groups, and compute resources.
  * It leverages modules for better organization and reusability of code.
  */

# VPC Configuration
module "vpc" {
  source = "../modules/vpc"

  project_name       = var.project_name
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  availability_zone  = var.availability_zone
}

# Security Group Configuration
module "security" {
  source = "../modules/security"

  project_name  = var.project_name
  vpc_id        = module.vpc.vpc_id
  ingress_ports = var.ingress_ports
}

# Compute Resource Configuration
module "compute" {
  source = "../modules/compute"

  project_name      = var.project_name
  public_subnet_id  = module.vpc.public_subnet_id
  security_group_id = module.security.security_group_id
  instance_type     = var.instance_type
  key_name          = var.key_name
  full_name         = var.full_name
}
