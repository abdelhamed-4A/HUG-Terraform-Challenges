aws_region = "us-east-1"
project_name = "HUG-Lagos-Ibadan-Terraform-Challenge"
environment = "dev"

vpc_cidr = "10.20.0.0/16"
availability_zones = ["us-east-1a", "us-east-1b"]
public_subnet_cidrs = ["10.20.1.0/24", "10.20.2.0/24"]
private_subnet_cidrs = ["10.20.101.0/24", "10.20.102.0/24"]

enable_nat_gateway = true
single_nat_gateway = true

instance_type = "t2.micro"
instance_count = 2
key_name = ""
full_name = "Abdel-Hamed Abdel-Nasser"

enable_alb = true
load_balancer_type = "application"

security_groups = {
  web = {
    description = "Allow SSH and HTTP access to EC2"
    ingress_rules = [
      {
        description = "SSH"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        description = "HTTP"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
    egress_rules = [
      {
        description = "All outbound"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }
  alb = {
    description = "Allow inbound HTTP to load balancer"
    ingress_rules = [
      {
        description = "HTTP"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
    egress_rules = [
      {
        description = "All outbound"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }
}

tags = {
  Owner = "abdelhamed-4A"
}
