variable "aws_region" {
  description = "AWS region to deploy resources into"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name prefix for resources"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
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
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDR blocks"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDR blocks"
  type        = list(string)
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

variable "security_groups" {
  description = "Security group definitions keyed by group name"
  type = map(object({
    description = string
    ingress_rules = list(object({
      description = string
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
    egress_rules = list(object({
      description = string
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
  }))
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
