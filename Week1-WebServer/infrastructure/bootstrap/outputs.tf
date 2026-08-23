output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = module.vpc.public_subnet_id
}

output "security_group_id" {
  description = "ID of the web security group"
  value       = module.security.security_group_id
}

output "instance_id" {
  description = "ID of the EC2 web server instance"
  value       = module.compute.instance_id
}

output "instance_public_ip" {
  description = "Public IP of the web server (browse here to see the page)"
  value       = module.compute.public_ip
}

output "instance_public_dns" {
  description = "Public DNS of the web server"
  value       = module.compute.public_dns
}

output "web_url" {
  description = "URL to view the deployed web page"
  value       = "http://${module.compute.public_ip}"
}
