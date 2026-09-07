output "vpc_id" { value = module.vpc.vpc_id }
output "public_subnet_id" { value = module.networking.public_subnet_id }
output "private_subnet_ids" { value = module.networking.private_subnet_ids }
output "web_public_ip" { value = module.compute.public_ip }
output "web_url" { value = "http://${module.compute.public_ip}" }
output "database_endpoint" { value = module.database.db_endpoint }
