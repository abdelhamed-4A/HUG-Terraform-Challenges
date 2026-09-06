output "instance_ids" {
  description = "Created EC2 instance IDs"
  value       = aws_instance.web[*].id
}

output "public_ips" {
  description = "Public IPs for instances"
  value       = aws_instance.web[*].public_ip
}

output "public_dns" {
  description = "Public DNS records for instances"
  value       = aws_instance.web[*].public_dns
}

output "launch_template_id" {
  description = "Launch template ID for auto-scaling readiness"
  value       = aws_launch_template.web.id
}
