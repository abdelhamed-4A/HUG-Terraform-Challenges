/**
  * # Security Module
  * This module provisions a security group in the specified VPC with the provided ingress ports.
  * It allows inbound traffic on the specified ports and allows all outbound traffic.
  * The security group is tagged with the project name for easy identification.
  */

resource "aws_security_group" "web" {
  name        = "${var.project_name}-web-sg"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_ports
    iterator = port
    content {
      description = "Allow inbound traffic on port ${port.value}"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "${var.project_name}-web-sg"
  }
}
