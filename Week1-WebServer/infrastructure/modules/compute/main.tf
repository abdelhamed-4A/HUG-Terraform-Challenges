/**
  * # Compute Module
  * This module provisions an EC2 instance in the specified public subnet with the provided security group
  * and key pair. It also fetches the latest Amazon Linux 2 AMI for the instance.
  * The instance is configured to run a web application using user data.
  *
  */

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-x86_64-gp2"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

}

resource "aws_instance" "web" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = var.key_name != "" ? var.key_name : null
  associate_public_ip_address = true

  user_data = templatefile("${path.module}/../../scripts/user_data.tftpl", {
    full_name    = var.full_name
    project_name = var.project_name
  })

  tags = {
    Name = "${var.project_name}-web-server"
  }
}
