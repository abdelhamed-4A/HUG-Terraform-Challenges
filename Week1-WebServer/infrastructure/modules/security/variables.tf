variable "project_name" {
  description = "Project/prefix name used for tagging resources"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC to attach the security group to"
  type        = string
}


variable "ingress_ports" {
  description = "List of ports to allow inbound traffic on"
  type        = list(number)
}
