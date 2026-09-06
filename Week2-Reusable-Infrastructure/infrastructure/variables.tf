variable "aws_region" {
  description = "AWS region to deploy resources into"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name prefix for resources"
  type        = string
  default     = "HUG-Terraform-Challenge-Week2"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "enable_dns_support" {
  description = "Enable DNS support in VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in VPC"
  type        = bool
  default     = true
}

variable "availability_zones" {
  description = "Availability zones used for subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "enable_nat_gateway" {
  description = "Whether to create NAT gateway(s)"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Create a single NAT gateway when true"
  type        = bool
  default     = true
}

variable "ingress_ports" {
  description = "List of ingress ports to allow"
  type        = list(number)
  default     = [22, 80, 443]
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 2
}

variable "key_name" {
  description = "Existing key pair name, leave empty to skip"
  type        = string
  default     = ""
}

variable "full_name" {
  description = "Full name shown on web page"
  type        = string
  default     = "Abdel-Hamed Abdel-Nasser"
}

variable "enable_alb" {
  description = "Enable ALB/NLB deployment"
  type        = bool
  default     = true
}

variable "load_balancer_type" {
  description = "Type of load balancer: application or network"
  type        = string
  default     = "application"

  validation {
    condition     = contains(["application", "network"], var.load_balancer_type)
    error_message = "load_balancer_type must be either application or network."
  }
}

variable "tags" {
  description = "Common tags applied to resources"
  type        = map(string)
  default     = {}
}
