variable "create_module" {
  description = "Toggle load balancer module resources"
  type        = bool
  default     = true
}

variable "project_name" {
  description = "Project name prefix"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "lb_type" {
  description = "Load balancer type"
  type        = string
  default     = "application"

  validation {
    condition     = contains(["application", "network"], var.lb_type)
    error_message = "lb_type must be application or network."
  }
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets for LB"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security groups for ALB only"
  type        = list(string)
  default     = []
}

variable "target_instance_ids" {
  description = "Instance IDs to register in target group"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
