# Week 2 - Reusable Infrastructure with Advanced Module Architecture

This project extends Week 1 into a production-ready reusable Terraform architecture.

## Architecture

- **VPC module**: dedicated VPC + DNS settings only.
- **Networking module**: public/private subnets, route tables, IGW, optional NAT Gateway(s).
- **Security module**: multiple security groups with dynamic ingress/egress rule maps.
- **Compute module**: multi-instance EC2 deployment + launch template for ASG readiness.
- **ALB module**: ALB/NLB support with listener, target group, and target attachments.

## Directory Structure

```text
Week2-ReusableInfrastructure/
├── infrastructure/
│   ├── backend.tf
│   ├── main.tf
│   ├── providers.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── terraform.tfvars
│   ├── terraform.tfvars.example
│   └── modules/
│       ├── vpc/
│       ├── networking/
│       ├── security/
│       ├── compute/
│       └── alb/
├── environments/
├── scripts/
├── screenshots/
└── examples/
```

## Remote State Management (S3 + DynamoDB)

`infrastructure/backend.tf` is configured with:
- S3 backend key: `week-2/terraform.tfstate`
- Server-side encryption enabled (`encrypt = true`)
- DynamoDB state locking table: `terraform-state-locks`

Bootstrap backend resources:

```bash
cd scripts
./setup_backend.sh
```

## Deployment

```bash
cd infrastructure
terraform init
terraform plan -var-file=terraform.tfvars -var-file=../environments/dev.tfvars
terraform apply -var-file=terraform.tfvars -var-file=../environments/dev.tfvars
```

Repeat with `staging.tfvars` or `prod.tfvars` overlays.

## Reusability Patterns

1. Toggle NAT behavior using `enable_nat_gateway` and `single_nat_gateway`.
2. Scale compute with `instance_count`.
3. Switch LB mode via `load_balancer_type` (`application` or `network`).
4. Disable LB creation with `enable_alb = false`.
5. Define additional security groups by extending `security_groups` map.

## Outputs

The root module exports grouped objects for VPC, networking, security groups, compute instances, and load balancer details.

## Troubleshooting and Optimization Tips

- Run `terraform fmt -recursive` before planning.
- If backend lock errors occur, verify DynamoDB table exists and IAM allows `dynamodb:GetItem/PutItem/DeleteItem`.
- For cost optimization in dev, set `single_nat_gateway = true` and lower `instance_count`.

## Screenshots

- `screenshots/vpc-architecture.png`
- `screenshots/networking-setup.png`
- `screenshots/multiple-instances.png`
- `screenshots/security-groups.png`
- `screenshots/load-balancer.png`
- `screenshots/webpage.png`
