output "security_group_ids" {
  description = "Security group IDs keyed by provided name"
  value       = { for name, sg in aws_security_group.this : name => sg.id }
}
