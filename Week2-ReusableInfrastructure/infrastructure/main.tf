locals {
  common_tags = merge(var.tags, {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Week        = "2"
  })
}

module "vpc" {
  source = "./modules/vpc"

  project_name          = var.project_name
  environment           = var.environment
  vpc_cidr              = var.vpc_cidr
  enable_dns_support    = var.enable_dns_support
  enable_dns_hostnames  = var.enable_dns_hostnames
  tags                  = local.common_tags
}

module "networking" {
  source = "./modules/networking"

  project_name          = var.project_name
  environment           = var.environment
  vpc_id                = module.vpc.vpc_id
  availability_zones    = var.availability_zones
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
  enable_nat_gateway    = var.enable_nat_gateway
  single_nat_gateway    = var.single_nat_gateway
  tags                  = local.common_tags
}

module "security" {
  source = "./modules/security"

  project_name     = var.project_name
  environment      = var.environment
  vpc_id           = module.vpc.vpc_id
  security_groups  = var.security_groups
  tags             = local.common_tags
}

module "compute" {
  source = "./modules/compute"

  project_name             = var.project_name
  environment              = var.environment
  subnet_ids               = module.networking.public_subnet_ids
  security_group_ids       = [for name, id in module.security.security_group_ids : id if name == "web"]
  instance_type            = var.instance_type
  instance_count           = var.instance_count
  key_name                 = var.key_name
  full_name                = var.full_name
  user_data_template_path  = "${path.root}/../scripts/user_data.tftpl"
  tags                     = local.common_tags
}

module "alb" {
  source = "./modules/alb"

  create_module        = var.enable_alb
  project_name         = var.project_name
  environment          = var.environment
  lb_type              = var.load_balancer_type
  vpc_id               = module.vpc.vpc_id
  subnet_ids           = module.networking.public_subnet_ids
  security_group_ids   = [for name, id in module.security.security_group_ids : id if name == "alb"]
  target_instance_ids  = module.compute.instance_ids
  tags                 = local.common_tags
}
