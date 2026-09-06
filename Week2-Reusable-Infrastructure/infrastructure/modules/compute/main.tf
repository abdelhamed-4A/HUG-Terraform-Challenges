locals {
  user_data = templatefile("${path.root}/../scripts/user_data.tftpl", {
    full_name    = var.full_name
    project_name = var.project_name
    environment  = var.environment
  })
}

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

resource "aws_launch_template" "web" {
  name_prefix   = "${var.project_name}-${var.environment}-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  key_name      = var.key_name != "" ? var.key_name : null

  vpc_security_group_ids = var.security_group_ids

  user_data = base64encode(local.user_data)

  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "instance"
    tags = merge(var.tags, {
      Name = "${var.project_name}-${var.environment}-instance"
    })
  }

  tag_specifications {
    resource_type = "volume"
    tags = merge(var.tags, {
      Name = "${var.project_name}-${var.environment}-volume"
    })
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "web" {
  count    = var.instance_count
  subnet_id = var.subnet_ids[count.index % length(var.subnet_ids)]

  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-instance-${count.index + 1}"
  })

  lifecycle {
    create_before_destroy = true
  }
}
