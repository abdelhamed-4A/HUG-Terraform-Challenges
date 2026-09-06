# Multi-AZ Deployment Example

Run Terraform with default `terraform.tfvars` values to create two public and two private subnets spread across two AZs.

```bash
cd infrastructure
terraform init
terraform plan
terraform apply
```

Set `single_nat_gateway = false` to create one NAT Gateway per AZ.
