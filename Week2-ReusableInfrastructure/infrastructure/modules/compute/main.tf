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

locals {
  user_data = templatefile(var.user_data_template_path, {
    full_name    = var.full_name
    project_name = var.project_name
    environment  = var.environment
  })
}

resource "aws_instance" "web" {
  count = var.instance_count

  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_ids[count.index % length(var.subnet_ids)]
  vpc_security_group_ids      = var.security_group_ids
  key_name                    = var.key_name != "" ? var.key_name : null
  associate_public_ip_address = true
  user_data                   = local.user_data

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-web-${count.index + 1}"
    Role = "web"
  })
}

resource "aws_launch_template" "web" {
  name_prefix   = "${var.project_name}-${var.environment}-lt-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  key_name      = var.key_name != "" ? var.key_name : null
  user_data     = base64encode(local.user_data)

  network_interfaces {
    security_groups             = var.security_group_ids
    associate_public_ip_address = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = merge(var.tags, {
      Name = "${var.project_name}-${var.environment}-launch-template"
      Role = "web"
    })
  }
}
