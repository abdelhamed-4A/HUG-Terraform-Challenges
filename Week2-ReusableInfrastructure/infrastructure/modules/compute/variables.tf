variable "project_name" {
  description = "Project name prefix"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets where instances are created"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security groups attached to instances"
  type        = list(string)
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "instance_count" {
  description = "Number of instances"
  type        = number
  default     = 2
}

variable "key_name" {
  description = "Existing key pair name"
  type        = string
  default     = ""
}

variable "full_name" {
  description = "Full name to render on webpage"
  type        = string
}

variable "user_data_template_path" {
  description = "Absolute path to user-data template"
  type        = string
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
