variable "project_name" {
  description = "Project/prefix name used for tagging resources"
  type        = string
}

variable "public_subnet_id" {
  description = "ID of the public subnet to launch the instance in"
  type        = string
}

variable "security_group_id" {
  description = "ID of the security group to attach to the instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of an existing EC2 key pair for SSH access (leave empty to skip)"
  type        = string
  default     = ""
}

variable "full_name" {
  description = "Full name (Firstname Lastname) to display on the web page"
  type        = string
}
