# ALB/NLB Module

Creates either an Application Load Balancer or Network Load Balancer, a target group, listener, and target attachments.

## Notes
- Use `lb_type = "application"` for HTTP features.
- Use `lb_type = "network"` for TCP-based load balancing.
- Set `create_module = false` to disable all resources.
