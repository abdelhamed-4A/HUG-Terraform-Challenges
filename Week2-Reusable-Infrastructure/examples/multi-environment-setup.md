# Multi-Environment Setup

Use shared infrastructure variables plus per-environment overlays:

```bash
cd infrastructure
terraform plan -var-file=terraform.tfvars -var-file=../environments/dev.tfvars
terraform plan -var-file=terraform.tfvars -var-file=../environments/staging.tfvars
terraform plan -var-file=terraform.tfvars -var-file=../environments/prod.tfvars
```
