locals {
  common_tags = merge(var.tags, {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Week        = "2"
  })

  # Define security groups with dynamic ingress rules based on ingress_ports
  security_groups = {
    main = {
      description = "Security group for ${var.project_name}-${var.environment}"
      ingress_rules = [
        for port in var.ingress_ports : {
          description = "Allow port ${port}"
          from_port   = port
          to_port     = port
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
      egress_rules = [
        {
          description = "Allow all outbound"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    }
  }

  # Extract the main security group ID from the map
  main_security_group_id = module.security.security_group_ids["main"]
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

  depends_on = [module.vpc]
}

module "security" {
  source = "./modules/security"

  project_name    = var.project_name
  environment     = var.environment
  vpc_id          = module.vpc.vpc_id
  security_groups = local.security_groups
  tags            = local.common_tags

  depends_on = [module.vpc]
}

module "compute" {
  source = "./modules/compute"

  project_name       = var.project_name
  environment        = var.environment
  subnet_ids         = module.networking.public_subnet_ids
  security_group_ids = [local.main_security_group_id]
  instance_type      = var.instance_type
  instance_count     = var.instance_count
  key_name           = var.key_name
  full_name          = var.full_name
  tags               = local.common_tags

  depends_on = [module.networking, module.security]
}

module "alb" {
  count = var.enable_alb ? 1 : 0
  source = "./modules/alb"

  create_module        = var.enable_alb
  project_name         = var.project_name
  environment          = var.environment
  vpc_id               = module.vpc.vpc_id
  subnet_ids           = module.networking.public_subnet_ids
  security_group_ids   = [local.main_security_group_id]
  target_instance_ids  = module.compute.instance_ids
  lb_type              = var.load_balancer_type
  tags                 = local.common_tags

  depends_on = [module.compute]
}
