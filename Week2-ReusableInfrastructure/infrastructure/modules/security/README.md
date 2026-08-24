# Security Module

Creates multiple security groups with dynamic ingress/egress rules.

## Input pattern
Provide a `security_groups` map where each key represents one security group and value contains ingress/egress rule lists.

## Output
- `security_group_ids` map for easy cross-module wiring.
