# Module Composition Example

The root module composes:
1. `vpc` for base network boundary.
2. `networking` for subnets, routes, IGW, NAT.
3. `security` for dynamic security group rules.
4. `compute` for multiple EC2 nodes and launch template output.
5. `alb` to expose all compute targets via one entrypoint.

This separation allows each module to be reused independently in other projects.
