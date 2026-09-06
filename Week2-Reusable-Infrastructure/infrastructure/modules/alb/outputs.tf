output "lb_arn" {
  description = "Load balancer ARN"
  value       = try(aws_lb.this[0].arn, null)
}

output "lb_dns_name" {
  description = "Load balancer DNS name"
  value       = try(aws_lb.this[0].dns_name, null)
}

output "target_group_arn" {
  description = "Target group ARN"
  value       = try(aws_lb_target_group.this[0].arn, null)
}
