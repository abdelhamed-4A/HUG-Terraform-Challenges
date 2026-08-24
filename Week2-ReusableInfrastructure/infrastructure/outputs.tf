output "vpc" {
  description = "VPC information"
  value = {
    id         = module.vpc.vpc_id
    cidr_block = module.vpc.vpc_cidr
  }
}

output "networking" {
  description = "Networking resources"
  value = {
    public_subnet_ids  = module.networking.public_subnet_ids
    private_subnet_ids = module.networking.private_subnet_ids
    nat_gateway_ids    = module.networking.nat_gateway_ids
    internet_gateway_id = module.networking.internet_gateway_id
  }
}

output "security_group_ids" {
  description = "Security groups keyed by name"
  value       = module.security.security_group_ids
}

output "compute" {
  description = "Compute resource details"
  value = {
    instance_ids         = module.compute.instance_ids
    instance_public_ips  = module.compute.public_ips
    instance_public_dns  = module.compute.public_dns
    launch_template_id   = module.compute.launch_template_id
  }
}

output "load_balancer" {
  description = "Load balancer details"
  value = {
    arn         = module.alb.lb_arn
    dns_name    = module.alb.lb_dns_name
    target_group_arn = module.alb.target_group_arn
  }
}
