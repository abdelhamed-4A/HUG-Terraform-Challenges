# HashiCorp User Group (HUG) 30 Days Terraform Challenges

Welcome to the central repository for the **HUG Lagos & HUG Ibadan 30 Days Terraform Challenge** implementations. This repository tracks hands-on Infrastructure as Code (IaC) projects deployed on Amazon Web Services (AWS) using modern HashiCorp Terraform standards, modular architectures, and cloud security best practices.

---

## 🛠 Repository Architecture & Projects Overview

```text
HUG-Terraform-Challenges/
├── Week1-WebServer/                  # Single-tier web server & S3 remote state
├── Week2-Reusable-Infrastructure/    # Modular ALB, VPC, multi-AZ EC2, & environments
├── Week3-Two-Tier-Application/       # Secure two-tier compute (EC2) & database (RDS)
└── README.md                         # Main repository entry point
```

---

## 🚀 Projects Summary

### [Week 1: Automated Web Server Deployment](https://www.google.com/search?q=Week1-WebServer&utm_source=gemini)

* **Goal**: Provision an Amazon EC2 instance running Nginx inside a default VPC using Terraform.
* **Key Features**: Bootstrapped web server via `user_data`, security group configuration for HTTP/SSH, and S3 remote backend state management.

### [Week 2: Reusable & Modular Infrastructure](https://www.google.com/search?q=Week2-Reusable-Infrastructure&utm_source=gemini)

* **Goal**: Refactor infrastructure into reusable, single-responsibility modules supporting multiple environments (`dev`, `staging`, `prod`).
* **Key Features**: Modular VPC, multi-AZ public/private subnets, Security Group chaining, Application Load Balancer (ALB), EC2 Launch Templates, and native S3 state locking (`use_lockfile = true`).

### [Week 3: Two-Tier Cloud Application](https://www.google.com/search?q=Week3-Two-Tier-Application&utm_source=gemini)

* **Goal**: Deploy a secure, production-grade two-tier application decoupling compute from database workloads.
* **Key Features**: Public EC2 compute tier (Nginx), private Amazon RDS PostgreSQL database tier, Multi-AZ DB Subnet Group, NAT Gateway for outbound connectivity, and strict least-privilege security group chaining.

---

## 🔐 Core Infrastructure & Security Principles

1. **Modular Architecture**: All environments leverage modular code structures (`vpc`, `networking`, `security`, `compute`, `database`, `alb`) promoting reusability and clean separation of concerns.
2. **Least-Privilege Network Isolation**: Backend resources (such as Amazon RDS) reside in private subnets with public access disabled (`publicly_accessible = false`). Inbound database traffic is restricted exclusively to the Compute Security Group ID (`source_security_group_id`).
3. **Remote State Management**: All project states are maintained centrally in Amazon S3 buckets with server-side encryption enabled and modern native S3 conditional write locking (`use_lockfile = true`).
4. **Secret Management**: Sensitive data (such as database credentials and personal IP addresses) are managed via `terraform.tfvars` files, which are strictly untracked and excluded from version control via `.gitignore`.

---

## 📋 Prerequisites & Tools

* **Terraform CLI**: `>= 1.10.0`
* **AWS CLI**: Authenticated with appropriate IAM permissions for VPC, EC2, RDS, ELB, and S3 resources.
* **Git**: Installed locally for version control.

---

## ⚙️ Quick Start Runbook

1. **Clone the Repository**:
```bash
git clone [https://github.com/abdelhamed-4A/HUG-Terraform-Challenges.git](https://github.com/abdelhamed-4A/HUG-Terraform-Challenges.git)
cd HUG-Terraform-Challenges
```


2. **Navigate to the Desired Challenge Directory**:
```bash
cd Week3-Two-Tier-Application/infrastructure
```


3. **Configure Local Variables**:
Copy the example variables template and supply your specific configuration values:
```bash
cp terraform.tfvars.example terraform.tfvars
```


4. **Initialize, Plan, & Deploy**:
```bash
terraform init
terraform plan
terraform apply --auto-approve
```


5. **Teardown**:
To prevent unexpected AWS charges, destroy resources when testing is complete:
```bash
terraform destroy --auto-approve
```



---

## 👤 Author

**Abdel-Hamed Abdel-Nasser**

*DevOps & Cloud Infrastructure Engineer*

* GitHub: [@abdelhamed-4A](https://www.google.com/search?q=https://github.com/abdelhamed-4A&utm_source=gemini)