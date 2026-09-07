locals {
  common_tags = merge(var.tags, {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Challenge   = "Week3"
  })
}

module "vpc" {
  source = "../modules/vpc"

  project_name = var.project_name
  environment  = var.environment
  vpc_cidr     = var.vpc_cidr
  tags         = local.common_tags
}

module "networking" {
  source = "../modules/networking"

  project_name         = var.project_name
  environment          = var.environment
  vpc_id               = module.vpc.vpc_id
  availability_zones   = var.availability_zones
  public_subnet_cidr   = var.public_subnet_cidr
  private_subnet_cidrs = var.private_subnet_cidrs
  tags                 = local.common_tags

  depends_on = [module.vpc]
}

module "security" {
  source = "../modules/security"

  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.vpc.vpc_id
  admin_ip     = var.admin_ip
  db_port      = 5432
  tags         = local.common_tags

  depends_on = [module.vpc]
}

module "database" {
  source = "../modules/database"

  project_name      = var.project_name
  environment       = var.environment
  subnet_ids        = module.networking.private_subnet_ids
  security_group_id = module.security.db_security_group_id
  allocated_storage = var.db_allocated_storage
  instance_class    = var.db_instance_class
  db_username       = var.db_username
  db_password       = var.db_password
  tags              = local.common_tags

  depends_on = [module.networking, module.security]
}

module "compute" {
  source = "../modules/compute"

  project_name      = var.project_name
  environment       = var.environment
  subnet_id         = module.networking.public_subnet_id
  security_group_id = module.security.web_security_group_id
  instance_type     = var.instance_type
  key_name          = var.key_name
  full_name         = var.full_name
  db_endpoint       = module.database.db_endpoint
  tags              = local.common_tags

  depends_on = [module.networking, module.security, module.database]
}
