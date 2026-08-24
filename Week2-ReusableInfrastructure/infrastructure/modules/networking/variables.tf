variable "project_name" {
  description = "Project name prefix"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "Target VPC ID"
  type        = string
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs"
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_cidrs) == length(var.availability_zones)
    error_message = "public_subnet_cidrs must match the number of availability_zones."
  }
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs"
  type        = list(string)

  validation {
    condition     = length(var.private_subnet_cidrs) == length(var.availability_zones)
    error_message = "private_subnet_cidrs must match the number of availability_zones."
  }
}

variable "enable_nat_gateway" {
  description = "Enable NAT gateway resources"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Use only one NAT gateway"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
